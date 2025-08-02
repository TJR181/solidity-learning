-include .env

build:; forge build

deploy-sepolia:
	forge script script/DeployFundMe.s.sol \
	--account sepolia --rpc-url $(SEPOLIA_RPC) --broadcast --verify \
	--etherscan-api-key $(ETHERSCAN_API_KEY) -vvv