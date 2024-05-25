"use client";
import { useEffect, useState } from "react";
import ConnectModal from "@/components/ConnectModal";
import { useAccount, useContractRead, useDisconnect } from "@starknet-react/core";
import abi from "@/app/abi/AgregatorAbi.json";
import IncreaseCountModal from "@/components/IncreaseCountModal";
import ContractOwnerModal from "@/components/ContractOwner";

export default function Home() {
	const { address } = useAccount();
  const { disconnect } = useDisconnect();
	const contractAddress =
		"0x2da68c5361610f7ec2366483926fe32160b217fa28e3ebc54cbe2f69fd51b90";
	const [openConnectModal, setConnectModal] = useState(false);
  const [increaseCount, setIncreaseCount ] = useState(false);
  const [killSwitchStatus, setKillSwitchStatus ] = useState(false);


	const toggleModal = () => {
		setConnectModal((prev) => !prev);
	};


  const toggleModal2 = () => {
		setIncreaseCount((prev) => !prev);
	};



  const toggleModal3 = () => {
		setKillSwitchStatus((prev) => !prev);
	};

	const {
		data: count,
		isLoading: countLoading,
	} = useContractRead({
		functionName: "get_aggr_count",
		abi,
		address: contractAddress,
		watch: true,
	});



  const {
		data: owner,
		isLoading: ownerLoading,
	} = useContractRead({
		functionName: "fetch_ownable_contract_owner",
    args: ["0x10643c1ad9f6effd8af79b32163977e803db69aae21444005044aeea85efc52"],
		abi,
		address: contractAddress,
		watch: true,
	});



  
const handleToggleIncreaseCount = () => {
  if(address) {
    setIncreaseCount(true)
  }else{
    alert("Please connect wallet before perfoming this transaction")
  }
}
	return (
		<main className=" bg-black min-h-screen  px-24 pt-8">
			<nav className="flex items-center justify-between gap-5">
        <p className="text-xl font-bold">Aggregator App</p>
				{!address ? (
					<button
						onClick={() => setConnectModal(true)}
						className="bg-orange-500 rounded-full px-5 py-2"
					>
						Connect Wallet
					</button>
				) : (
					<div className="flex flex-col items-center gap-5">
						<div className="">
            <p className="text-white text-xs">Connected Wallet: {address.slice(0, 6)}...{address.slice(6, 11)}</p>
            </div>
						<button onClick={() => disconnect()} className="bg-orange-500 text-sm  rounded-full px-5 py-2">
							Disconnect
						</button>
					</div>
				)}
			</nav>

			<div className="flex flex-col items-center justify-between pt-[100px]">
				<p className="py-4 text-6xl">Count: {countLoading ? "Loading..." : <span className="font-[900]">{count?.toString()} </span>}</p>
        <p className="py-4 text-xl">Contract Owner Address: {ownerLoading ? "Loading..." : <span className="font-[900] text-sm">0x{owner?.toString().slice(0, 6)}...{owner?.toString().slice(6, 12)} </span>}</p>


        <div className="flex gap-8 ">
        {/* <button onClick={toggleModal3} className="bg-transparent hover:bg-orange-500 hover:border-orange-500 border border-gray-100 mt-6  rounded-full px-5 py-3">Contract Owner</button> */}
        <button onClick={() => handleToggleIncreaseCount()} className="bg-orange-500 hover:border mt-6 hover:bg-transparent hover:border-gray-100  rounded-full px-5 py-3">Increase Count by 2</button>

        </div>
			</div>

			<ConnectModal isOpen={openConnectModal} onClose={toggleModal} />

      <IncreaseCountModal isOpen={increaseCount} onClose={toggleModal2} />

      <ContractOwnerModal isOpen={killSwitchStatus} onClose={toggleModal2} />

		</main>
	);
}
