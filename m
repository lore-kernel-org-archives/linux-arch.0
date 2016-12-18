From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] mm: make pagoff_t type 64-bit
Date: Sun, 18 Dec 2016 10:23:29 +0100
Message-ID: <20161218092329.GA16618@lst.de>
References: <1481461003-14361-1-git-send-email-ynorov@caviumnetworks.com> <1481461003-14361-4-git-send-email-ynorov@caviumnetworks.com> <2636242.RWRJivuddj@wuerfel> <20161216105514.GA466@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <libc-alpha-return-76050-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
Content-Disposition: inline
In-Reply-To: <20161216105514.GA466@yury-N73SV>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Arnd Bergmann <arnd@arndb.de>, libc-alpha@sourceware.org, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, "Joseph S. Myers" <joseph@codesourcery.com>, zhouchengming1@huawei.com, "Kapoor, Prasun" <Prasun.Kapoor@caviumnetworks.com>, Alexander Graf <agraf@suse.de>, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com, Alexey Klimov <klimov.linux@gmail.com>, broonie@kernel.org, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Nathan Lynch <Nathan_Lynch@mentor.com>, Martin Schwidefsky <schwidefsky@de.ibm.c>
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 16, 2016 at 04:25:14PM +0530, Yury Norov wrote:
>  1 leave things as is. 32-bit architectures will have no option to
>    mmap big offsets, and no one cares - as usual.

And that's the only sensible option.
