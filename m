From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] arch: sparc: prom: looping issue, need additional
 length check in the outside looping
Date: Wed, 19 Jun 2013 02:13:42 -0700 (PDT)
Message-ID: <20130619.021342.853193458609177361.davem@davemloft.net>
References: <51A6C8FA.3080408@asianux.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51A6C8FA.3080408@asianux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gang.chen@asianux.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sam@ravnborg.org, sparclinux@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Chen Gang <gang.chen@asianux.com>
Date: Thu, 30 May 2013 11:35:22 +0800

> 
> When "cp >= barg_buf + BARG_LEN-2", it breaks internel looping 'while',
> but outside loop 'for' still has effect, so "*cp++ = ' '" will continue
> repeating which may cause memory overflow.
> 
> So need additional length check for it in the outside looping.
> 
> Also beautify the related code which found by "./scripts/checkpatch.pl"

Applied.
