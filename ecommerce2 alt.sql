-- MySQL Script generated by MySQL Workbench
-- Thu Sep 22 14:35:51 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Nome / Razão social` VARCHAR(45) NULL,
  `Cpf / Cnpj` INT NULL,
  `Endereço` VARCHAR(45) NULL,
  `E-mail` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `Cpf / Cnpj_UNIQUE` (`Cpf / Cnpj` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vendedores terceirizados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vendedores terceirizados` (
  `idVendedor` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Razão social` VARCHAR(45) NULL,
  `Cnpj / Cpf` INT NULL,
  `Local` VARCHAR(45) NULL,
  `Pedido` VARCHAR(45) NULL,
  PRIMARY KEY (`idVendedor`),
  UNIQUE INDEX `Cnpj / Cpf_UNIQUE` (`Cnpj / Cpf` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pagamento` (
  `idPagamento` INT NOT NULL,
  `Valor` VARCHAR(45) NULL,
  `A vista` VARCHAR(45) NULL,
  `Boleto` VARCHAR(45) NULL,
  `Cartão crédito` VARCHAR(45) NULL,
  `Cartão Débito` VARCHAR(45) NULL,
  `Pix` VARCHAR(45) NULL,
  `Transferência bancária` VARCHAR(45) NULL,
  PRIMARY KEY (`idPagamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `idPedido` INT NOT NULL,
  `Número do Pedido` VARCHAR(45) NULL,
  `Endereço` VARCHAR(45) NULL,
  `Status do pedido` VARCHAR(45) NULL,
  `Descrição do pedido` VARCHAR(45) NULL,
  `Frete` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Pagamento_idPagamento` INT NOT NULL,
  PRIMARY KEY (`idPedido`, `Cliente_idCliente`, `Pagamento_idPagamento`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Pedido_Pagamento1_idx` (`Pagamento_idPagamento` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Pagamento1`
    FOREIGN KEY (`Pagamento_idPagamento`)
    REFERENCES `mydb`.`Pagamento` (`idPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Departamento` (
  `idDepartamento` INT NOT NULL,
  `Categoria` VARCHAR(45) NULL,
  PRIMARY KEY (`idDepartamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto` (
  `idProduto` INT NOT NULL,
  `Códido do Produto` VARCHAR(45) NULL,
  `Desrição do produto` VARCHAR(45) NULL,
  `Valor do produto` INT NULL,
  `Custo fornecedor` INT NULL,
  `Fornecedor` VARCHAR(45) NULL,
  `Departamento_idDepartamento` INT NOT NULL,
  PRIMARY KEY (`idProduto`, `Departamento_idDepartamento`),
  INDEX `fk_Produto_Departamento1_idx` (`Departamento_idDepartamento` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_Departamento1`
    FOREIGN KEY (`Departamento_idDepartamento`)
    REFERENCES `mydb`.`Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fornecedor` (
  `idFornecedor` INT NOT NULL,
  `Razão social` VARCHAR(45) NULL,
  `Cnpj / Cpf` INT NULL,
  `Produto` VARCHAR(45) NULL,
  PRIMARY KEY (`idFornecedor`),
  UNIQUE INDEX `Cnpj / Cpf_UNIQUE` (`Cnpj / Cpf` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Frete`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Frete` (
  `idFrete` INT NOT NULL,
  `Tipo` VARCHAR(45) NULL,
  `Código do pedido` VARCHAR(45) NULL,
  `Endereço` VARCHAR(45) NULL,
  `Códido de rastreio` VARCHAR(45) NULL,
  `Cliente` VARCHAR(45) NULL,
  `Statud do pedido` VARCHAR(45) NULL,
  PRIMARY KEY (`idFrete`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Devolução`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Devolução` (
  `idDevolução` INT NOT NULL,
  `Códido de devolução` VARCHAR(45) NULL,
  `Devolvido` TINYINT NULL,
  PRIMARY KEY (`idDevolução`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Disponibilizando Produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Disponibilizando Produtos` (
  `Fornecedor_idFornecedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`Fornecedor_idFornecedor`, `Produto_idProduto`),
  INDEX `fk_Fornecedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Fornecedor_has_Produto_Fornecedor_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_has_Produto_Fornecedor`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `mydb`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estoque` (
  `idEstoque` INT NOT NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Quantidade em Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Quantidade em Estoque` (
  `Produto_idProduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Estoque_idEstoque`),
  INDEX `fk_Produto_has_Estoque_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  INDEX `fk_Produto_has_Estoque_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `mydb`.`Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Relação de produto por pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Relação de produto por pedido` (
  `Produto_idProduto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Pedido_idPedido`),
  INDEX `fk_Produto_has_Pedido_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  INDEX `fk_Produto_has_Pedido_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Pedido_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produtos pro vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produtos pro vendedor` (
  `Produto_idProduto` INT NOT NULL,
  `Vendedores terceirizados_idVendedor` INT NOT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Vendedores terceirizados_idVendedor`),
  INDEX `fk_Produto_has_Vendedores terceirizados_Vendedores terceiri_idx` (`Vendedores terceirizados_idVendedor` ASC) VISIBLE,
  INDEX `fk_Produto_has_Vendedores terceirizados_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Vendedores terceirizados_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Vendedores terceirizados_Vendedores terceiriza1`
    FOREIGN KEY (`Vendedores terceirizados_idVendedor`)
    REFERENCES `mydb`.`Vendedores terceirizados` (`idVendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Devolução de pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Devolução de pedido` (
  `Pedido_idPedido` INT NOT NULL,
  `Pedido_Cliente_idCliente` INT NOT NULL,
  `Devolução_idDevolução` INT NOT NULL,
  `Motivo da devolução` VARCHAR(45) NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Pedido_Cliente_idCliente`, `Devolução_idDevolução`),
  INDEX `fk_Pedido_has_Devolução_Devolução1_idx` (`Devolução_idDevolução` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Devolução_Pedido1_idx` (`Pedido_idPedido` ASC, `Pedido_Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_has_Devolução_Pedido1`
    FOREIGN KEY (`Pedido_idPedido` , `Pedido_Cliente_idCliente`)
    REFERENCES `mydb`.`Pedido` (`idPedido` , `Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Devolução_Devolução1`
    FOREIGN KEY (`Devolução_idDevolução`)
    REFERENCES `mydb`.`Devolução` (`idDevolução`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido_has_Frete`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido_has_Frete` (
  `Pedido_idPedido` INT NOT NULL,
  `Pedido_Cliente_idCliente` INT NOT NULL,
  `Pedido_Pagamento_idPagamento` INT NOT NULL,
  `Frete_idFrete` INT NOT NULL,
  `Endereço` VARCHAR(45) NULL,
  `Tipo de frete` VARCHAR(45) NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Pedido_Cliente_idCliente`, `Pedido_Pagamento_idPagamento`, `Frete_idFrete`),
  INDEX `fk_Pedido_has_Frete_Frete1_idx` (`Frete_idFrete` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Frete_Pedido1_idx` (`Pedido_idPedido` ASC, `Pedido_Cliente_idCliente` ASC, `Pedido_Pagamento_idPagamento` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_has_Frete_Pedido1`
    FOREIGN KEY (`Pedido_idPedido` , `Pedido_Cliente_idCliente` , `Pedido_Pagamento_idPagamento`)
    REFERENCES `mydb`.`Pedido` (`idPedido` , `Cliente_idCliente` , `Pagamento_idPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Frete_Frete1`
    FOREIGN KEY (`Frete_idFrete`)
    REFERENCES `mydb`.`Frete` (`idFrete`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Devolução do pedido - Frete`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Devolução do pedido - Frete` (
  `Devolução_idDevolução` INT NOT NULL,
  `Frete_idFrete` INT NOT NULL,
  `Pago por Cliente` TINYINT NULL,
  `Pago por Vendedor` TINYINT NULL,
  PRIMARY KEY (`Devolução_idDevolução`, `Frete_idFrete`),
  INDEX `fk_Devolução_has_Frete_Frete1_idx` (`Frete_idFrete` ASC) VISIBLE,
  INDEX `fk_Devolução_has_Frete_Devolução1_idx` (`Devolução_idDevolução` ASC) VISIBLE,
  CONSTRAINT `fk_Devolução_has_Frete_Devolução1`
    FOREIGN KEY (`Devolução_idDevolução`)
    REFERENCES `mydb`.`Devolução` (`idDevolução`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Devolução_has_Frete_Frete1`
    FOREIGN KEY (`Frete_idFrete`)
    REFERENCES `mydb`.`Frete` (`idFrete`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;