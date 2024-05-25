import { useEffect, useMemo, useState } from "react";
import GenericModal from "./GenericModal";

import abi from "@/app/abi/AgregatorAbi.json";
import {
	useContractRead,
} from "@starknet-react/core";

type Props = {
	isOpen: boolean;
	onClose: () => void;
};



const ContractOwnerResult = ({address}: {address: string}) => {

  const { data, isLoading } = useContractRead({
    functionName: "fetch_ownable_contract_owner",
    args: [address],
    abi,
    address: "0x2da68c5361610f7ec2366483926fe32160b217fa28e3ebc54cbe2f69fd51b90",
    watch: true,
  });

  console.log(data, "hellow")

  return <>
  </>

}

const ContractOwner = ({ isOpen, onClose }: Props) => {
	const [animate, setAnimate] = useState(false);
  const [shouldFetch, setShouldFetch] = useState(false);
	const [payload, setPayload] = useState({
		contract_owner: "",
	});


	const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
		const { name, value } = e.target;
		setPayload((prev) => ({ ...prev, [name]: value }));
	};

	const closeModal = (e: React.MouseEvent<HTMLButtonElement>) => {
		e.stopPropagation();
		setAnimate(false);
		setTimeout(() => {
			onClose();
		}, 400);
	};

	useEffect(() => {
		if (isOpen) {
			setAnimate(true);
		} else {
			setAnimate(false);
		}
	}, [isOpen]);





	return (
		<GenericModal
			isOpen={isOpen}
			onClose={closeModal}
			animate={animate}
			className={`w-[40vw] mx-auto md:h-[20rem] md:w-[30rem] text-white `}
		>
			<div className="flex p-4 w-full">
				<div className="basis-5/6 lg:col-span-2  ">
					<h2 className="text-center my-4 lg:text-start font-bold text-white text-[1.125em]">
					Contract Owner
					</h2>
				</div>
				<div className="ml-auto lg:col-span-3 lg:py-4 lg:pr-8">
					<button
						onClick={(e) => {
							closeModal(e);
							e.stopPropagation();
						}}
						className="w-8 h-8  grid place-content-center rounded-full bg-outline-grey  "
					>
						<svg
							xmlns="http://www.w3.org/2000/svg"
							width="24"
							height="24"
							viewBox="0 0 24 24"
						>
							<path
								fill="currentColor"
								d="m6.4 18.308l-.708-.708l5.6-5.6l-5.6-5.6l.708-.708l5.6 5.6l5.6-5.6l.708.708l-5.6 5.6l5.6 5.6l-.708.708l-5.6-5.6z"
							/>
						</svg>
					</button>
				</div>
			</div>
			<div className="flex flex-col flex-1 justify-between">
				<div className="px-8  lg:h-full lg:col-span-2 ">
					<div className="space-y-5">
						<input
							onChange={handleChange}
							placeholder="Paste contract address"
							name="contract_owner"
							className="px-5 py-3 bg-transparent border rounded-lg border-gray-500 outline w-full"
						/>
					</div>

					<button onClick={() => setShouldFetch(true)} className="bg-orange-500 px-4 rounded-full py-2 w-full mt-10">
					 {/* {loading ? "Loading...." : "	Submit"} */}
           Submit
					</button>
				</div>
			</div>

      {
          shouldFetch && !payload.contract_owner && <ContractOwnerResult address={payload.contract_owner} />
      }
		</GenericModal>
	);
};

export default ContractOwner;
