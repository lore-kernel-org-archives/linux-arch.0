From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2] asm-generic: Drop renameat syscall from default list
Date: Mon, 02 May 2016 15:23:12 +0200
Message-ID: <5769874.XvA4zrbPZs@wuerfel>
References: <1461965366-7893-1-git-send-email-james.hogan@imgtec.com> <C2D7FE5348E1B147BCA15975FBA23075F4EA010A@us01wembx1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F4EA010A-cALIpNOex2c3t6iM5Z/N3fufCSb+aD3WLzEdoUbNIic@public.gmane.org>
Sender: linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Chen Liqin <liqin.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Aurelien Jacquiot <a-jacquiot-l0cyMroinI0@public.gmane.org>, "linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org" <linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org>, Richard Kuo <rkuo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>, Lennox Wu <lennox.wu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Metcalf <cmetcalf-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, Ley Foon Tan <lftan-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>, "nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org" <nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org>, Yoshin
List-Id: linux-arch.vger.kernel.org

On Monday 02 May 2016 05:13:46 Vineet Gupta wrote:
> On Saturday 30 April 2016 02:59 AM, James Hogan wrote:
> > The newer renameat2 syscall provides all the functionality provided by
> > the renameat syscall and adds flags, so future architectures won't need
> > to include renameat.
> >
> > Therefore drop the renameat syscall from the generic syscall list unless
> > __ARCH_WANT_RENAMEAT is defined by the architecture's unistd.h prior to
> > including asm-generic/unistd.h, and adjust all architectures using the
> > generic syscall list to define it so that no in-tree architectures are
> > affected.
> >
> > Signed-off-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> 
> Acked-by: Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>  # for arch/arc

Applied to the asm-generic, tree, thanks!

	Arnd
