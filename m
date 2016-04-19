From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch/defconfig: remove CONFIG_RESOURCE_COUNTERS
Date: Tue, 19 Apr 2016 12:56:55 +0200
Message-ID: <4214150.v1WFzl5UmK@wuerfel>
References: <146105442758.18940.2792564159961963110.stgit@zurg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <146105442758.18940.2792564159961963110.stgit@zurg>
Sender: owner-linux-mm@kvack.org
To: Konstantin Khlebnikov <koct9i@gmail.com>, x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-am33-list@redhat.com, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tuesday 19 April 2016 11:27:07 Konstantin Khlebnikov wrote:
> This option replaced by PAGE_COUNTER which is selected by MEMCG.
> 
> Signed-off-by: Konstantin Khlebnikov <koct9i@gmail.com>
> 
Acked-by: Arnd Bergmann <arnd@arndb.de>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
