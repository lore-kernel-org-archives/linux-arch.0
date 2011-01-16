From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 00/24] Introduce little endian bitops
Date: Sun, 16 Jan 2011 10:57:18 -0800
Message-ID: <AANLkTikWZYOqxD_CyJ=zF2Lp2Mnt6Z2E1aPUspwMjrz_@mail.gmail.com>
References: <1295183333-13802-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295183333-13802-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, Russell King <rmk@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Sun, Jan 16, 2011 at 5:08 AM, Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
> This problem is not touched.

So why not? The thing is supposed to be a cleanup, but it generates
uglier code and more lines added than removed. Why should I pull
something like that?

                    Linus
