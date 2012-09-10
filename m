From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 02/31] arm64: Kernel booting and initialisation
Date: Mon, 10 Sep 2012 14:48:20 +0000
Message-ID: <201209101448.20745.arnd@arndb.de>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <201209101353.34325.arnd@arndb.de>
 <alpine.LFD.2.02.1209101007160.28681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.LFD.2.02.1209101007160.28681@xanadu.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Monday 10 September 2012, Nicolas Pitre wrote:
> On Mon, 10 Sep 2012, Arnd Bergmann wrote:
> > On Monday 10 September 2012, Catalin Marinas wrote:
> > > On Mon, Sep 10, 2012 at 06:53:39AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > I think a bunch of other architectures can have relocatable kernels, which
> > is useful e.g. for kdump. It does imply a small runtime cost and may have
> > other disadvantages though.
> 
> Relocatable in physical space is what kdump actually needs, and that's 
> what we already have here (as well as on ARM32 for that matter with 
> CONFIG_ARM_PATCH_PHYS_VIRT).  Relocatable in the virtual space is costly 
> and we shouldn't need to go there.

Ah, I see. I thought that the other architectures (powerpc and x86)
doing this were actually building with -fPIC, but they do the same
kind of early patching that we do.

	Arnd
