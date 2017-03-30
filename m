From: Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH] percpu: drop useless macro PER_CPU_DEF_ATTRIBUTES
Date: Thu, 30 Mar 2017 11:34:56 +0800
Message-ID: <58DC7CE0.4080402@cn.fujitsu.com>
References: <1490690107-30009-1-git-send-email-caoj.fnst@cn.fujitsu.com>
 <20170328160040.GC28157@htj.duckdns.org> <58DB1E19.4020501@cn.fujitsu.com>
 <20170329152827.GB30385@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:52960 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754771AbdC3DZ5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2017 23:25:57 -0400
In-Reply-To: <20170329152827.GB30385@htj.duckdns.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, cl@linux.com



On 03/29/2017 11:28 PM, Tejun Heo wrote:
> On Wed, Mar 29, 2017 at 10:38:17AM +0800, Cao jin wrote:
>> On 03/29/2017 12:00 AM, Tejun Heo wrote:
>>> On Tue, Mar 28, 2017 at 04:35:07PM +0800, Cao jin wrote:
>>>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>>>
>>> I'm not sure.  I think I used it during development and it's not like
>>> it costs anything to keep.
>>
>> It easily confusing newbies without any comments for its purpose.
> 
> percpu variable handling is pretty complex to begin with.  I don't buy
> that an empty default attribute macro adds anything noticeable there.
> 
>> Temporary using during development seems not good to persist. Could I
>> know its purpose?
> 
> I don't remember the exact details but at the same time I don't see
> the value of the proposed change.  We can apply or not apply the patch
> and either way wouldn't make any noticeable difference.  What's the
> point?
> 
> Thanks.
> 

It doesn't matter whether apply or not. I just start to read these code
and want to know what every tiny symbol is for.  Thanks for your time.
-- 
Sincerely,
Cao jin
