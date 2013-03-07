From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Byteorder conditional compilation problems
Date: Thu, 7 Mar 2013 08:17:00 +0100
Message-ID: <CAMuHMdWcONApHZV6J-oCkQeiyUESU9y_hpWT9cA37MGGvmgG1Q@mail.gmail.com>
References: <31680.1362588189@warthog.procyon.org.uk>
	<CA+55aFw5aqVCpsSAyy5VFhk4UwgBxKpOikVz-AC3kLJsxe0Ygw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:37586 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab3CGHRB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Mar 2013 02:17:01 -0500
In-Reply-To: <CA+55aFw5aqVCpsSAyy5VFhk4UwgBxKpOikVz-AC3kLJsxe0Ygw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Joakim.Tjernlund@transmode.se, Andrew Morton <akpm@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Mar 6, 2013 at 6:37 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Mar 6, 2013 at 8:43 AM, David Howells <dhowells@redhat.com> wrote:
>> Scripting a change from "defined(__XXX_ENDIAN)" to "(__XXX_ENDIAN==__BYTEORDER)"
>> should be easy to script.
>
> How about we just make the rule be that we shouldn't test __xyz_ENDIAN
> at all, and instead always use CONFIG_xyz_ENDIAN, which isn't
> ambiguous. And then have the exporter of the uapi header files just
> sed-script that into __xyz_ENDIAN == __BYTEORDER.

I was going to suggest a checkpatch test, but your suggestion is a
better solution.
Still, we may want the checkpatch test, to make sure no one explicitly does the
moronic byte order check.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
