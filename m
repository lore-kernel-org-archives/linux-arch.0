From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: sparc: prom: looping issue, need additional length
 check in the outside looping
Date: Wed, 19 Jun 2013 17:24:20 +0800
Message-ID: <51C178C4.7030400@asianux.com>
References: <51A6C8FA.3080408@asianux.com> <20130619.021342.853193458609177361.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:60076 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933755Ab3FSJZM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Jun 2013 05:25:12 -0400
In-Reply-To: <20130619.021342.853193458609177361.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sam@ravnborg.org, sparclinux@vger.kernel.org

On 06/19/2013 05:13 PM, David Miller wrote:
> From: Chen Gang <gang.chen@asianux.com>
> Date: Thu, 30 May 2013 11:35:22 +0800
> 
>>
>> When "cp >= barg_buf + BARG_LEN-2", it breaks internel looping 'while',
>> but outside loop 'for' still has effect, so "*cp++ = ' '" will continue
>> repeating which may cause memory overflow.
>>
>> So need additional length check for it in the outside looping.
>>
>> Also beautify the related code which found by "./scripts/checkpatch.pl"
> 
> Applied.
> 
> 

Thank you very much.


-- 
Chen Gang

Asianux Corporation
