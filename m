From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 00/45] remove in-kernel syscall invocations (part 3 ==
 remainder outside arch/)
Date: Thu, 22 Mar 2018 13:29:20 -0700
Message-ID: <CA+55aFwTZgivpcx6keE1vX7EyvmMmQaiux25U39-r2tDBUzfBQ@mail.gmail.com>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 22, 2018 at 2:00 AM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> Here is a third series of patches which reduce the number of syscall
> invocations from within the kernel. Once this long-term goal is achieved,
> the syscall entry path can be streamlined.

Looks good to me.

              Linus
