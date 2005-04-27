Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 27 Apr 2005 13:50:15 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] consolidate sys_shmat
Message-ID: <20050427125015.GU30431@linux-mips.org>
References: <20050323150123.1a78e9c4.sfr@canb.auug.org.au> <20050323174810.17df4440.sfr@canb.auug.org.au> <20050323145132.GJ21986@parcelfarce.linux.theplanet.co.uk> <20050405180132.15e386cd.sfr@canb.auug.org.au> <20050405130312.GC16157@parcelfarce.linux.theplanet.co.uk> <20050427162709.6851e14b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427162709.6851e14b.sfr@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Wed, Apr 27, 2005 at 04:27:09PM +1000, Stephen Rothwell wrote:

> I have minimised this patch a bit.  It now just consolidates sys_shmat and
> in doing so, "fixes" the ABIs for MIPS(64) and ARM.  ARM glibc does not
> use the sys_shmnat syscall directly so far (as far as I can see) and on
> MIPS64, the ABI that glibc seems to expect (I am pretty much guessing) is
> the fixed one.

Correct, so the patch is looking ok.

  Ralf
