From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Introducing a nanoMIPS port for Linux
Date: Thu, 3 May 2018 18:40:07 -0400
Message-ID: <CAK8P3a2y2EA1g099DXOHkfevQb=6zuWmVOq9C_wVTQ8zrAMx8w@mail.gmail.com>
References: <20180502215107.GA9884@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180502215107.GA9884@saruman>
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>, Matt Redfearn <matt.redfearn@mips.com>, Marcin Nowakowski <marcin.nowakowski@mips.com>, Matthew Fortune <Matthew.Fortune@mips.com>
List-Id: linux-arch.vger.kernel.org

On Wed, May 2, 2018 at 5:51 PM, James Hogan <jhogan@kernel.org> wrote:

> Due to the binary incompatibility between previous MIPS architecture
> generations and nanoMIPS, and the significantly revamped compiler ABI,
> where for the first time, a single Linux kernel would not be expected to
> handle both old and new ABIs, we have decided to also take the
> opportunity to modernise the Linux user ABI for nanoMIPS, making as much
> use of generic interfaces as possible and modernising the true
> architecture specific parts.
>
> This is similar to what a whole new kernel architecture would be
> expected to adopt, but has been done within the existing MIPS
> architecture port to allow reuse of the existing MIPS code, most of
> which does not depend on these ABI specifics. Details of the proposed
> Linux user ABI changes for nanoMIPS can be found here:

While I haven't looked at the individual changes, I wonder whether
it would be useful to make this new ABI use 64-bit time_t from
the start, using the new system calls that Deepa and I have been
posting recently. There are still a few things to be worked out:
only the first of four sets of syscall patches is merged so far,
and we have a couple of areas that will require further ABI changes
(sound, sockets, media and maybe a couple of smaller drivers),
so it depends on the overall timing. If you would otherwise merge
the patches quickly, then it may be better to just follow the existing
32-bit architectures and add the 64-bit entry points when we do it
for everyone.

         Arnd
