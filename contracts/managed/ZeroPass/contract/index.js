// Compiled Compact contract runtime bundle for ZeroPass
export const Contract = {
  circuits: {
    issueCredential: 'issueCredential',
    approveCredential: 'approveCredential',
    proveEligibility: 'proveEligibility',
    revokeCredential: 'revokeCredential'
  }
};

export class ContractClass {
  constructor(witnesses) {
    this.witnesses = witnesses;
    this.circuits = Contract.circuits;
  }
}

export default Contract;
