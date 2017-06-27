From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Tue, 27 Jun 2017 09:48:19 +0100
Message-ID: <20170627084818.GD5759@arm.com>
References: <20170607131611.GF30263@arm.com>
 <mhng-107d5417-a33b-4b20-96cb-6adead7c3130@palmer-si-x1c4>
 <8709419e3d964b86b025bb35a6b55440@HQMAIL105.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8709419e3d964b86b025bb35a6b55440@HQMAIL105.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lustig <dlustig@nvidia.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, "peterz@infradead.org" <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "albert@sifive.com" <albert@sifive.com>, "patches@groups.riscv.org" <patches@groups.riscv.org>
List-Id: linux-arch.vger.kernel.org

Hi Dan,

On Tue, Jun 27, 2017 at 12:07:20AM +0000, Daniel Lustig wrote:
> > > https://github.com/riscv/riscv-isa-manual/releases/download/riscv-user
> > > -2.2/riscv-spec-v2.2.pdf
> > 
> > That's the most up to date spec.
> 
> Yes, that's the most up to date public spec.  Internally, the RISC-V memory
> model task group has been working on fixing the memory model spec for the
> past couple of months now.  We're aiming to release it for public review
> well before the end of the year.  Hopefully in the coming weeks even.

Excellent, cheers for the update.

> > > which, on the one hand is reassuring (because ignoring dependency
> > > ordering is plain broken), but on the other it doesn't go quite far
> > > enough in defining exactly what constitutes a "syntactic data
> > > dependency". The cumulativity of your fences also needs defining,
> > > because I think this was up in the air at some point and the document
> > > above doesn't seem to tackle it (it doesn't seem to describe what
> > > constitutes being a memory of the predecessor or successor sets)
> 
> That will all covered in the new spec.
> 
> > > P.S. You should also totally get your architects to write a formal
> > > model ;)
> 
> Also in progress :)

3/3 :)

> Were there any more specific questions I can answer in the meantime?  Or
> any specific concern you'd like to point me to?

Nothing specific, but we won't be able to review the
memory-ordering/atomics/locking parts of this patch series until we have
a spec.

Will
