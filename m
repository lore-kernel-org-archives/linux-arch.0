From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] kvm: provide kvm.h for all architecture:
	fixes	headers_install
Date: Tue, 11 Mar 2008 07:42:25 +0100
Message-ID: <1205217745.2592.86.camel@shinybook.infradead.org>
References: <200803071326.06682.borntraeger@de.ibm.com>
	<1204933418.2495.14.camel@shinybook.infradead.org>
	<200803101411.04175.borntraeger@de.ibm.com>
	<20080310232039.d2a34f5a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20080310232039.d2a34f5a.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel@lists.sourceforge.net>
List-Help: <mailto:kvm-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: kvm-devel-bounces@lists.sourceforge.net
Errors-To: kvm-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, mm-commits@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Avi Kivity <avi@qumranet.com>, David Howells <dhowells@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Sam Ravnborg <sam@ravnborg.org>
List-Id: linux-arch.vger.kernel.org


On Mon, 2008-03-10 at 23:20 -0700, Andrew Morton wrote:
> 
> > Changes since v1:
> > o use asm-generic/Kbuild.asm (Arnd Bergmann)

I don't see that in the diffstat of the patch you dropped (looking at
the immediately subsequent mail in my inbox). Which might explain...

> /usr/src/devel/usr/include/linux/kvm.h requires asm/kvm.h, which does
> not exist in exported headers

-- 
dwmw2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
