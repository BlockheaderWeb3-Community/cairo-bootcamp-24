import React from 'react'

export default function GenericModal({
  isOpen,
  onClose,
  animate,
  children,
  className,
  position,
}: {
  isOpen: boolean;
  onClose: (e: React.MouseEvent<HTMLButtonElement>) => void;
  animate: boolean;
  children: React.ReactNode;
  className?: string;
  position?: string;
}) {
  return (
    <>
      {isOpen && (
        <section
          onClick={onClose}
          className={`fixed h-screen w-screen grid  top-0 left-0  z-[99]  backdrop-blur ${
            position ? position : "justify-center items-center"
          }  ${!isOpen ? "hidden" : ""}`}
        >
          <div
            onClick={(e) => e.stopPropagation()}
            className={`bg-[#1c1b1f] rounded-[25px] flex flex-col border-[1px] border-solid border-outline-grey transition-[opacity,transform] duration-500 ease-in-out ${
              animate
                ? "translate-y-0 opacity-100"
                : "translate-y-full opacity-0"
            } ${className}`}
          >
            {children}
          </div>
        </section>
      )}
    </>
  )
}
