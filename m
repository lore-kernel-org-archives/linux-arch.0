From: Szeredi Miklos <miklos-sUDqSbJrdHQHWmgEVkV9KA@public.gmane.org>
Subject: Re: [RFC 3/3] asm-generic: Drop renameat syscall from default list
Date: Tue, 29 Apr 2014 13:24:36 +0200
Message-ID: <CAELBmZB=74foyc_b-MTVOXeP6rVAD2x4=um2RVezTb68DifEbA@mail.gmail.com>
References: <1398247687-13453-1-git-send-email-james.hogan@imgtec.com>
	<1398247687-13453-4-git-send-email-james.hogan@imgtec.com>
	<201404231418.05174.arnd@arndb.de>
	<CAAG0J9-2=rP3RP08eEjd17R3wEaeiUtGfWD-LeqXV=y9sBamfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAG0J9-2=rP3RP08eEjd17R3wEaeiUtGfWD-LeqXV=y9sBamfA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Miklos Szeredi <mszeredi-AlSwsSmVLrQ@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Aurelien Jacquiot <a-jacquiot-l0cyMroinI0@public.gmane.org>, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, Richard Kuo <rkuo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, metag <linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>, linux-ZwoEplunGu2h2975yA52AaxOck334EZe@public.gmane.org, Chen Liqin <liqin.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lennox Wu <lennox.wu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 23, 2014 at 2:41 PM, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org> wrote:

> It appears Miklos Szeredi beat me to it with patch 1 (adding renameat2
> syscall to asm-generic unistd.h), and will be submitting it to Linus
> at some point as part of his renameat2 series.
> Miklos: Do you think it makes sense for you to include my second patch
> in your series too since it's renameat2 related?
> http://marc.info/?l=linux-kernel&m=139824773305016&w=2

I've queued up the first two patches with acks from Arnd.

Thanks,
Miklos
--
To unsubscribe from this list: send the line "unsubscribe linux-metag" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
