From: Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH] percpu: drop useless macro PER_CPU_DEF_ATTRIBUTES
Date: Wed, 29 Mar 2017 10:38:17 +0800
Message-ID: <58DB1E19.4020501@cn.fujitsu.com>
References: <1490690107-30009-1-git-send-email-caoj.fnst@cn.fujitsu.com>
 <20170328160040.GC28157@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:9993 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752414AbdC2C31 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Mar 2017 22:29:27 -0400
In-Reply-To: <20170328160040.GC28157@htj.duckdns.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, cl@linux.com



On 03/29/2017 12:00 AM, Tejun Heo wrote:
> On Tue, Mar 28, 2017 at 04:35:07PM +0800, Cao jin wrote:
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> 
> I'm not sure.  I think I used it during development and it's not like
> it costs anything to keep.
> 

It easily confusing newbies without any comments for its purpose.

Temporary using during development seems not good to persist. Could I
know its purpose?

-- 
Sincerely,
Cao jin
