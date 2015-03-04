From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: nios2: is the ptrace ABI correct?
Date: Wed, 04 Mar 2015 17:56:28 -0300
Message-ID: <54F7717C.5070406@vanguardiasur.com.ar>
References: <CAAEAJfDjDYY-Z6cPyrddCXiFJzrjNx8jkSAJZuokeEM9NU6WWg@mail.gmail.com> <10088870.tldQegtTla@wuerfel> <54EDB2FC.4050901@vanguardiasur.com.ar> <10841724.NbdcAaCe1a@wuerfel> <54F03184.7080600@codesourcery.com> <54F052B1.4070300@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54F052B1.4070300@vanguardiasur.com.ar>
Sender: linux-kernel-owner@vger.kernel.org
To: Chung-Lin Tang <cltang@codesourcery.com>, Arnd Bergmann <arnd@arndb.de>, Ley Foon Tan <lftan@altera.com>
Cc: Tobias Klauser <tklauser@distanz.ch>, Walter Goossens <waltergoossens@home.nl>, linux-arch@vger.kernel.org, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi all,

I have here a patch to rework most of the UAPI headers, so the info
exported to userspace is sane. The ABI itself is left untouched.

This will allow to support strace (which is ready since a few weeks now)
and will sanitize the UAPIs. The ABI itself is ugly as hell, but I don't
want to break it.

Given the lack of replies on this thread, I guess nobody cares much
about nios2 mainline. Anyway... I'll try to submit a patchset soon and
I'll appreciate if the libc can take a look and make sure everything is OK.
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
