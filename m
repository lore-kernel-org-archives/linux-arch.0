From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH v2 32/40] avr32: macro whitespace fixes
Date: Wed, 7 Jan 2015 07:52:35 +0100
Message-ID: <20150107065235.GB18142@samfundet.no>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
 <1420558883-10131-33-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420558883-10131-33-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@gmail.com>
List-Id: linux-arch.vger.kernel.org

Around Tue 06 Jan 2015 17:45:18 +0200 or thereabout, Michael S. Tsirkin wrote:
> While working on arch/avr32/include/asm/uaccess.h, I noticed
> that some macros within this header are made harder to read because they
> violate a coding style rule: space is missing after comma.
> 
> Fix it up.

Thank you (-:

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  arch/avr32/include/asm/uaccess.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

<snipp diff>

-- 
mvh
Hans-Christian Egtvedt
