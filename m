From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH v3 02/31] arm64: Kernel booting and initialisation
Date: Mon, 10 Sep 2012 17:21:02 +0200
Message-ID: <20120910152102.GD31430@game.jcrosoft.org>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-3-git-send-email-catalin.marinas@arm.com>
 <20120909172046.GB31430@game.jcrosoft.org>
 <alpine.LFD.2.02.1209091923180.28681@xanadu.home>
 <20120910055339.GC31430@game.jcrosoft.org>
 <20120910125137.GC27042@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20120910125137.GC27042@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-arch.vger.kernel.org

On 13:51 Mon 10 Sep     , Catalin Marinas wrote:
> On Mon, Sep 10, 2012 at 06:53:39AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 19:29 Sun 09 Sep     , Nicolas Pitre wrote:
> > > On Sun, 9 Sep 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > On 17:26 Fri 07 Sep     , Catalin Marinas wrote:
> > > > > +The image must be placed at the specified offset (currently 0x80000)
> > > > > +from the start of the system RAM and called there. The start of the
> > > > > +system RAM must be aligned to 2MB.
> > > > can we drop this
> > > 
> > > Drop what?
> > > And why?
> > This contrain the must be loadable at any address
> 
> You can't easily load the kernel image at any address, unless it can
> relocate itself and you have a way to specify PHYS_OFFSET. We don't want
> a compile-time PHYS_OFFSET, the kernel detects it at boot time based on
> the load address.
so NACK kexec and other boot loaders require it

Best Regards,
J.
