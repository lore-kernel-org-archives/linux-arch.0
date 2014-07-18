From: Chung-Lin Tang <cltang@codesourcery.com>
Subject: Re: [PATCH v2 22/29] nios2: Miscellaneous header files
Date: Fri, 18 Jul 2014 14:15:07 +0800
Message-ID: <53C8BB6B.5050606@codesourcery.com>
References: <1405413956-2772-1-git-send-email-lftan@altera.com> <4999408.jEEY9BVX9F@wuerfel> <53C50A87.6000902@codesourcery.com> <4477048.XUlURsz4uq@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <4477048.XUlURsz4uq@wuerfel>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, "Joseph S. Myers" <joseph@codesourcery.com>
List-Id: linux-arch.vger.kernel.org

Hi Arnd,
Considering two other kernel interface issues that appeared earlier in
the context of nios2 glibc/kernel upstreaming:

(1) The 64-bit time_t/timespec issue.
(2) Dropping renameat by default in favor of renameat2

What's the decision for these? Are they delayed to the next release?

Thanks,
Chung-Lin
