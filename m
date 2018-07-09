From: "greg@kroah.com" <greg@kroah.com>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Date: Mon, 9 Jul 2018 09:06:35 +0200
Message-ID: <20180709070635.GB13285@kroah.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
 <20180709054842.GB7618@kroah.com>
 <1d34b6addd98c3219f902e0dc0c2922309e1de93.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1d34b6addd98c3219f902e0dc0c2922309e1de93.camel@synopsys.com>
Sender: stable-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 09, 2018 at 06:46:50AM +0000, Alexey Brodkin wrote:
> Hi Greg,
> 
> On Mon, 2018-07-09 at 07:48 +0200, Greg KH wrote:
> > On Mon, Jul 09, 2018 at 07:44:44AM +0300, Alexey Brodkin wrote:
> > > Depending on ABI "long long" type of a particular 32-bit CPU
> > > might be aligned by either word (32-bits) or double word (64-bits).
> > > Make sure "data" is really 64-bit aligned for any 32-bit CPU.
> > > 
> > > At least for 32-bit ARC cores ABI requires "long long" types
> > > to be aligned by normal 32-bit word. This makes "data" field aligned to
> > > 12 bytes. Which is still OK as long as we use 32-bit data only.
> > > 
> > > But once we want to use native atomic64_t type (i.e. when we use special
> > > instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
> > > misaligned access exception.
> > 
> > So is this something you hit today?  If not, why is this needed for
> > stable kernels?
> 
> Indeed we hit that problem recently when Etnaviv driver was switched to
> DRM GPU scheduler, see
> commit e93b6deeb45a ("drm/etnaviv: hook up DRM GPU scheduler").
> The most important part of DRM GPU scheduler is "job_id_count" member of
> "drm_gpu_scheduler" structure of type "atomic64_t". This structure is put
> in a buffer allocated by devm_kzalloc() and if "job_id_count" is not 64-bit
> aligned atomic instruction fails with an exception.
> 
> As for stable requirements - mentioned commit was a part of 4.17 kernel
> which broke GPU driver for one of our HSDK board so I guess back-porting
> to 4.17 is a no-brainer.

Ok, so 4.17 is as far back as you need?  Please try to be specific when
asking for stable backports.

> > > That's because even on CPUs capable of non-aligned data access LL/SC
> > > instructions require strict alignment.
> > 
> > Are you going to hit this code with all types of structures?
> 
> If there're other cases which lead to 4-byte aligned "atomic64_t" variables
> there will be a problem as well but it's quite hard to predict those cases.
> That said if we manage to reproduce more similar issues there will be more
> patches with fixes :)
> 
> > What happens when you do have an unaligned access?
> 
> Atomic instructions are a bit special as compared to normal loads and stores.
> Even if normal loads and stores may deal with unaligned data atomic instructions
> still require data to be aligned because it's hard to manage atomic value that
> spans through multiple cache lines or even MMU pages. And hardware just
> raises an alignment fault exception.
> 
> And that's not something special for ARC, I guess all CPUs are the same in
> that regard, see here's an extract from ARM(r) Architecture Reference
> Manual ARMv7-A and ARMv7-R edition: https://lkml.org/lkml/2017/12/5/440
> From "Table A3-1 Alignment requirements of load/store instructions"
> it's seen that LDREXD, STREXD instructions will cause alignment fault
> even if SCTLR.A=0 (strict alignment fault checking disabled) for non
> double-word-aligned data.

Thanks for the better explaination, that helps out a lot.  Can you redo
the patch with all of that information so that others do not have the
same questions as I did?

thanks,

greg k-h
