From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [GIT PULL] arch: remove obsolete architecture ports
Date: Mon, 02 Apr 2018 19:57:13 -0700 (PDT)
Message-ID: <mhng-ef075a77-24a8-4764-bb5d-c4b06722c0bb@palmer-si-x1c4>
References: <CAK8P3a0q70FYtBaCcsBPejVULgsbJPwUG7QmrkU9NJpr7oTzpQ@mail.gmail.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0q70FYtBaCcsBPejVULgsbJPwUG7QmrkU9NJpr7oTzpQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, jhogan@kernel.org, dhowells@redhat.com, linux-am33-list@redhat.com, takata@linux-m32r.org, lennox.wu@gmail.com, Aaron.Wu@analog.com, cooloney@gmail.com, chris.d.metcalf@gmail.com, jesper.nilsson@axis.com
List-Id: linux-arch.vger.kernel.org

On Mon, 02 Apr 2018 00:17:30 PDT (-0700), Arnd Bergmann wrote:
> - openrisc, risc-v and nds32 are still in the process of finishing their
>   support or getting it added to mainline gcc in the first place.
>   They all have patched gcc-7.3 ports that work to some degree, but
>   complete upstream support won't happen before gcc-8.1. Csky posted
>   their first kernel patch set last week, their situation will be similar.

FWIW, RISC-V landed in GCC 7.  The 7.3.0 release (and binutils-2.30) is the 
first one we recommend for kernel development as there have been a handful of 
bug fixes, but there's nothing major.  SiFive ships GCC versions with a few 
extra patches applied, and while I still recommend people use these they should 
all be performance improvements at this point.  With compilers you never know 
if a performance improvement is hiding a bug, but what's tagged as gcc-7.3.0 
passes the test suite.

Our 32-bit glibc port isn't upstream yet, but our 32-bit kernel is a bit of a 
mess so that's not the blocking issue in rv32-land right now :).
