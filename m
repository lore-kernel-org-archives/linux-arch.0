From: "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: RE: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 09:16:25 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612B802D25BE@IRSMSX102.ger.corp.intel.com>
References: <20180103223827.39601-1-mark.rutland@arm.com>
 <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop>
 <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
 <CAPcyv4ic=X3nMz7deg9NMyvj994+SM9XYoP0u7WvgKaAFSGAYw@mail.gmail.com>
 <alpine.LRH.2.00.1801040253410.27010@gjva.wvxbf.pm>
 <20180104021553.32084de3@alans-desktop>
 <20180104031239.f2sat4ozqvqxaatr@ast-mbp.dhcp.thefacebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180104031239.f2sat4ozqvqxaatr@ast-mbp.dhcp.thefacebook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Jiri Kosina <jikos@kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

> On Thu, Jan 04, 2018 at 02:15:53AM +0000, Alan Cox wrote:
> >
> > > > Elena has done the work of auditing static analysis reports to a dozen
> > > > or so locations that need some 'nospec' handling.
> > >
> > > How exactly is that related (especially in longer-term support terms) to
> > > BPF anyway?
> >
> > If you read the papers you need a very specific construct in order to not
> > only cause a speculative load of an address you choose but also to then
> > manage to cause a second operation that in some way reveals bits of data
> > or allows you to ask questions.
> >
> > BPF allows you to construct those sequences relatively easily and it's
> > the one case where a user space application can fairly easily place code
> > it wants to execute in the kernel. Without BPF you have to find the right
> > construct in the kernel, prime all the right predictions and measure the
> > result without getting killed off. There are places you can do that but
> > they are not so easy and we don't (at this point) think there are that
> > many.
> 
> for BPF in particular we're thinking to do a different fix.
> Instead of killing speculation we can let cpu speculate.
> The fix will include rounding up bpf maps to nearest power of 2 and
> inserting bpf_and operation on the index after bounds check,
> so cpu can continue speculate beyond bounds check, but it will
> load from zero-ed memory.
> So this nospec arch dependent hack won't be necessary for bpf side,
> but may still be needed in other parts of the kernel.

I think this is a much better approach than what we have been doing internally so
far. My initial fix back in August for this was to insert a minimal set of lfence
barriers (osb() barrier below) that prevent speculation just based on how attack was using constants
to index eBPF maps:

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
#define BPF_R0	regs[BPF_REG_0]
@@ -939,6 +940,7 @@ static unsigned int ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn,
 		DST = IMM;
 		CONT;
 	LD_IMM_DW:
+		osb();
 		DST = (u64) (u32) insn[0].imm | ((u64) (u32) insn[1].imm) << 32;
 		insn++;
 		CONT;
@@ -1200,6 +1202,7 @@ static unsigned int ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn,
 		*(SIZE *)(unsigned long) (DST + insn->off) = IMM;	\
 		CONT;							\
 	LDX_MEM_##SIZEOP:						\
+		osb();							\
 		DST = *(SIZE *)(unsigned long) (SRC + insn->off);	\
 		CONT;
 


And similar stuff also for x86 JIT (blinding dependent):

@@ -400,7 +413,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			case BPF_ADD: b2 = 0x01; break;
 			case BPF_SUB: b2 = 0x29; break;
 			case BPF_AND: b2 = 0x21; break;
-			case BPF_OR: b2 = 0x09; break;
+			case BPF_OR: b2 = 0x09; emit_memory_barrier(&prog); break;
 			case BPF_XOR: b2 = 0x31; break;
 			}
 			if (BPF_CLASS(insn->code) == BPF_ALU64)
@@ -647,6 +660,16 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		case BPF_ALU64 | BPF_RSH | BPF_X:
 		case BPF_ALU64 | BPF_ARSH | BPF_X:
 
+			/* If blinding is enabled, each
+			 * BPF_LD | BPF_IMM | BPF_DW instruction
+			 * is converted to 4 eBPF instructions with
+			 * BPF_ALU64_IMM(BPF_LSH, BPF_REG_AX, 32)
+			 * always present(number 3). Detect such cases
+			 * and insert memory barriers. */
+			if ((BPF_CLASS(insn->code) == BPF_ALU64)
+				&& (BPF_OP(insn->code) == BPF_LSH)
+				&& (src_reg == BPF_REG_AX))
+				emit_memory_barrier(&prog);
 			/* check for bad case when dst_reg == rcx */
 			if (dst_reg == BPF_REG_4) {
 				/* mov r11, dst_reg */

But this is really ugly fix IMO to prevent speculation from happen, so with your
approach I think it is really much better. 

If you need help in testing the fixes, I can do it unless you already have the
attack code yourself. 

> 
> Also note that variant 1 is talking about exploiting prog_array
> bpf feature which had 64-bit access prior to
> commit 90caccdd8cc0 ("bpf: fix bpf_tail_call() x64 JIT")
> That was a fix for JIT and not related to this cpu issue, but
> I believe it breaks the existing exploit.

Actually I could not get existing exploit working on anything past 4.11
but at that time I could not see any fundamental change in eBPF that
would prevent it. 

Best Regards,
Elena.
