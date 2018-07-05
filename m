From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 18/19] clocksource: add C-SKY clocksource drivers
Date: Thu, 5 Jul 2018 13:03:12 +0800
Message-ID: <20180705050311.GA20088@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <aba005fd5005c066a2e3d760c334bb55f902d771.1530465326.git.ren_guo@c-sky.com>
 <alpine.DEB.2.21.1807031130050.1601@nanos.tec.linutronix.de>
 <20180704104957.GB23536@guoren>
 <alpine.DEB.2.21.1807041632140.1752@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807041632140.1752@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 04, 2018 at 04:35:43PM +0200, Thomas Gleixner wrote:
> On Wed, 4 Jul 2018, Guo Ren wrote:
> > On Tue, Jul 03, 2018 at 11:39:05AM +0200, Thomas Gleixner wrote:
> > > > +static inline u64 get_ccvr(void)
> > > > +{
> > > > +	u32 lo, hi, t;
> > > > +
> > > > +	do {
> > > > +		hi = mfcr(PTIM_CCVR_HI);
> > > > +		lo = mfcr(PTIM_CCVR_LO);
> > > > +		t  = mfcr(PTIM_CCVR_HI);
> > > > +	} while(t != hi);
> > > 
> > > No idea which frequency this timer ticks at, but if the 32 bit wrap does
> > > not come too fast, then you really should avoid that loop. That function is
> > > called very frequently.
> > 
> > 0000006c <clksrc_read>:
> > 		hi = mfcr(PTIM_CCVR_HI);
> >   6c:	c1c26023 	mfcr      	r3, cr<2, 14>
> > 		lo = mfcr(PTIM_CCVR_LO);
> >   70:	c1c36021 	mfcr      	r1, cr<3, 14>
> > 		t  = mfcr(PTIM_CCVR_HI);
> >   74:	c1c26022 	mfcr      	r2, cr<2, 14>
> > 	} while(t != hi);
> >   78:	648e      	cmpne      	r3, r2
> >   7a:	0bf9      	bt      	0x6c	// 6c <clksrc_read>
> > 
> > When two read cr<2, 14> is not equal, we'll retry. So only when
> > CCVR_LO is at 0xffffffff between the two read of CCVR_HI. That's very
> > very small probability event for "bt 0x6c".
> > 
> > Don't worry about the "do {...} whie(t != hi)", it's no performance issue.
> 
> But _three_ mfcr plus a conditional jump which _cannot_ be predicted are a
> performance issue. When you can replace that with a single mfcr, then you
> win a lot, really. The time keeping and the sched clock code can handle
> that nicely unless you really have fast wrap arounds on the LO word.
Timer's frequency is about 50Mhz-100Mhz and LO word wrap arounds timer is
about 42s ~ 84s.

Our Branch prediction buffer will let the CPU speculative execute
continually. So the "bt" won't be the performance issue.

And I could modify it like this:

static inline u64 get_ccvr(void)
{
	u32 lo, hi, t;

	t  = mfcr(PTIM_CCVR_LO);
	hi = mfcr(PTIM_CCVR_HI);
	lo = mfcr(PTIM_CCVR_LO);

	if (lo < t) hi++;

	return ((u64)hi << 32) | lo;
}

	t  = mfcr(PTIM_CCVR_LO);
  50:	c1c36023 	mfcr      	r3, cr<3, 14>
	hi = mfcr(PTIM_CCVR_HI);
  54:	c1c26021 	mfcr      	r1, cr<2, 14>
	lo = mfcr(PTIM_CCVR_LO);
  58:	c1c3602c 	mfcr      	r12, cr<3, 14>
	if (lo < t) hi++;
  5c:	64f0      	cmphs      	r12, r3
  5e:	c4210c21 	incf      	r1, r1, 1
	return ((u64)hi << 32) | lo;
  62:	3200      	movi      	r2, 0
 
Hmm? (No jump at all)

 Guo Ren
