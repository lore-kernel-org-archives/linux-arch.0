From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: RFC: remove the "tile" architecture from glibc
Date: Wed, 7 Mar 2018 17:08:09 +0100
Message-ID: <21665e92-27d1-81c5-5959-f0893541b515@physik.fu-berlin.de>
References: <1a57be83-3349-5450-ee4f-d2a33569a728@mellanox.com>
 <d6c8e425-a6b6-6594-05e3-965536f06da3@physik.fu-berlin.de>
 <abce89d0-6798-069a-1a54-06e664665b78@mellanox.com>
 <dc3c52ce-f082-0da0-7828-0d4e6751e2a5@physik.fu-berlin.de>
 <CAK8P3a3itR8i2ayG7e4ku7kz+CQU7qHhptdmtmgTz+CzFGmCiw@mail.gmail.com>
 <alpine.DEB.2.20.1803071557070.28840@digraph.polyomino.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1803071557070.28840@digraph.polyomino.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joseph Myers <joseph@codesourcery.com>, Arnd Bergmann <arnd@arndb.de>
Cc: GNU C Library <libc-alpha@sourceware.org>, linux-arch <linux-arch@vger.kernel.org>, metcalf@alum.mit.edu, Henrik Grindal Bakken <hgb@ifi.uio.no>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Helmut Grohne <helmutg@debian.org>
List-Id: linux-arch.vger.kernel.org

On 03/07/2018 05:00 PM, Joseph Myers wrote:
> No-one has posted glibc test results for 2.27 or 2.26, despite the prior
> claims of interest in keeping the glibc port.

To be honest, I find the rapid release model for glibc a bit annoying
as a downstream. Upstream projects which adopt this model and then require
constant attention from porters cause lots of stress for the less common
architectures. There are other upstream projects that want attention as
well and at some point it just will get extremely frustrating.

Is such a rapid release model really needed for something like a C library?

As for the testsuites: Adhemerval has gotten access from Debian to a
number of porterboxes for the various uncommon architectures, including
alpha, hppa, powerpcspe, sh4 and sparc64 and we're happy to give out
accounts to anyone interested.

And since Debian regularly updates glibc as well, you can get most testsuite
runs also by just checking the build logs (click on the green or red texts):

> https://buildd.debian.org/status/package.php?p=glibc&suite=sid

Note: Testsuites for sh4 and m68k are currently disabled.

Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
