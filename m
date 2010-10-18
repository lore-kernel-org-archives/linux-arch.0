From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 21/22] m68k: convert minix bitops to use little endian bitops
Date: Mon, 18 Oct 2010 10:58:24 +0200
Message-ID: <m3r5fnyj0v.fsf@hase.home>
References: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com>
	<1287135981-17604-22-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1287135981-17604-22-git-send-email-akinobu.mita@gmail.com>
	(Akinobu Mita's message of "Fri, 15 Oct 2010 18:46:20 +0900")
Sender: linux-m68k-owner@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, linux-m68k@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Akinobu Mita <akinobu.mita@gmail.com> writes:

> The inode and block bitmap for minix filesystem is little endian
> byte order on m68k.

No, it isn't.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
