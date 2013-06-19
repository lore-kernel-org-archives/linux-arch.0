Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:60801 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934588Ab3FSJNn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Jun 2013 05:13:43 -0400
Date: Wed, 19 Jun 2013 02:13:42 -0700 (PDT)
Message-ID: <20130619.021342.853193458609177361.davem@davemloft.net>
Subject: Re: [PATCH] arch: sparc: prom: looping issue, need additional
 length check in the outside looping
From: David Miller <davem@davemloft.net>
In-Reply-To: <51A6C8FA.3080408@asianux.com>
References: <51A6C8FA.3080408@asianux.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: gang.chen@asianux.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sam@ravnborg.org, sparclinux@vger.kernel.org
Message-ID: <20130619091342.jbLfOTlIqmB_BSxkqJYIsPDihPsEeOjbWnBRH2iakQw@z>

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
