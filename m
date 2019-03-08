From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] signal: fix building with clang
Date: Thu, 07 Mar 2019 16:27:19 -0800
Message-ID: <31b6d5bdfda9cbadffa6d8cb3ad0991e237a364c.camel@perches.com>
References: <20190307091218.2343836-1-arnd@arndb.de>
         <20190307152805.GA25101@redhat.com>
         <CAK8P3a2fuD-UBJET_OBKekCxrTDpnAxb0Bpu2LCCXaVT3pXTMQ@mail.gmail.com>
         <20190307164647.GC25101@redhat.com>
         <CAK8P3a2FU55-7wQnLXDAmRCgiZ-W+2rY6p7CrTiKNe0wda-Hsg@mail.gmail.com>
         <CAKwvOd=nyhM72CxdO-YYSsXr7rh3LUALn_ezVNzyiBaOD7KZkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKwvOd=nyhM72CxdO-YYSsXr7rh3LUALn_ezVNzyiBaOD7KZkA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Oleg Nesterov <oleg@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Christian Brauner <christian@brauner.io>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-mips@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, 2019-03-07 at 16:22 -0800, Nick Desaulniers wrote:
> On Thu, Mar 7, 2019 at 1:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > I'd have to try, but I think you are right. It was probably an
> > overoptimization back in 1997 when the code got added to
> > linux-2.1.68pre1, and compilers have become smarter in the
> > meantime ;-)
> 
> How do you track history pre-git (2.6.XX)?

https://landley.net/kdocs/fullhist/
