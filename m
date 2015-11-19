From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] include: asm-generic: page.h: Remove useless
 get_user_page and free_user_page
Date: Thu, 19 Nov 2015 16:18:43 +0000
Message-ID: <20151119161843.GA8644@n2100.arm.linux.org.uk>
References: <COL130-W7B5F0BB94C76AF6B12EA7B91C0@phx.gbl>
 <5663971.11WtULN11Y@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5663971.11WtULN11Y@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "jonas@southpole.se" <jonas@southpole.se>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "vgupta@synopsys.com" <vgupta@synopsys.com>, "abrodkin@synopsys.com" <abrodkin@synopsys.com>, kernel mailing list <linux-kernel@vger.kernel.org>, "dhowells@redhat.com" <dhowells@redhat.com>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>, linux-arm-kernel@lists.infradead.org, "gerg@uclinux.org" <gerg@uclinux.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Chen Gang <xili_gchen_5257@hotmail.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 19, 2015 at 12:25:45PM +0100, Arnd Bergmann wrote:
> On Thursday 19 November 2015 03:40:25 Chen Gang wrote:
> > diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
> > index 37d1fe2..67cfb7d 100644
> > --- a/include/asm-generic/page.h
> > +++ b/include/asm-generic/page.h
> > @@ -24,9 +24,6 @@
> >  
> >  #ifndef __ASSEMBLY__
> >  
> > -#define get_user_page(vaddr)           __get_free_page(GFP_KERNEL)
> > -#define free_user_page(page, addr)     free_page(addr)
> > -
> >  #define clear_page(page)       memset((page), 0, PAGE_SIZE)
> >  #define copy_page(to,from)     memcpy((to), (from), PAGE_SIZE)
> >  
> > 
> 
> Looks good. I can take the asm-generic portion when you split it up, and
> I can also help you merge the remaining patches in case some of
> the arch maintainers fail to pick them up. I think all five of them
> are actively maintained though, so the patches should just go through
> the respective architecture trees.

Or we just ack the patch and have it go through one tree, which I think
is the most sensible.  I can't imagine that there would be any major
conflicts here, surely no one is constantly changing their asm/page.h ?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
