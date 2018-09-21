Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38534 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeIUHZ7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Sep 2018 03:25:59 -0400
Subject: Re: [PATCH security-next v2 26/26] LSM: Add all exclusive LSMs to
 ordered initialization
References: <20180920162338.21060-1-keescook@chromium.org>
 <20180920162338.21060-27-keescook@chromium.org>
 <a0165ce9-d15b-eaef-a5e8-2aeb6bdc69f6@schaufler-ca.com>
 <CAGXu5j++wXMUXuqT7m5MZdeXqO=i7RgyKZoLwELfSTx6UPOVSA@mail.gmail.com>
 <7d2cc28b-aee5-ee91-9362-f92f8ca30adc@schaufler-ca.com>
From: John Johansen <john.johansen@canonical.com>
Message-ID: <6c899d9e-45aa-8159-c402-b3c4d1936112@canonical.com>
Date: Thu, 20 Sep 2018 18:39:12 -0700
MIME-Version: 1.0
In-Reply-To: <7d2cc28b-aee5-ee91-9362-f92f8ca30adc@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Casey Schaufler <casey@schaufler-ca.com>, Kees Cook <keescook@chromium.org>
Cc: James Morris <jmorris@namei.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20180921013912.FFp4Ukekb_WKzFjCnQW9CXjR3e16UcEWr3Rql9rvfqw@z>

On 09/20/2018 06:10 PM, Casey Schaufler wrote:
> On 9/20/2018 5:45 PM, Kees Cook wrote:
>> On Thu, Sep 20, 2018 at 5:25 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 9/20/2018 9:23 AM, Kees Cook wrote:
>>>>  config LSM_ORDER
>>>>       string "Default initialization order of builtin LSMs"
>>>> -     default "yama,loadpin,integrity"
>>>> +     default "yama,loadpin,integrity,selinux,smack,tomoyo,apparmor"
>>> If I want to compile all the major modules into my kernel and use
>>> AppArmor by default would I use
>>>
>>>         default "yama,loadpin,integrity,apparmor,selinux,smack,tomoyo"
>>>
>>> or
>>>
>>>         default "yama,loadpin,integrity,apparmor"
>> I was expecting the former, but the latter will have the same result.

t find having the two be equivalent violates expectations. At least
when considering the end goal of full/extreme stacking, its trivially
the same with current major lsms being exclusive

>>
>>> When we have "blob-sharing" how could I compile in tomoyo,
>>> but exclude it without a boot line option?
>> Ooh, yes, this series has no way to do that. Perhaps
>> CONFIG_LSM_DISABLE in the same form as CONFIG_LSM_ORDER? I would
>> totally remove LoadPin's CONFIG for this in favor it.
> 
> I would generally prefer an optional CONFIG_LSM_ENABLE to
> CONFIG_LSM_DISABLE, but I understand the logic behind your
> approach. I would be looking for something like
> 
+1 on the CONFIG_LSM_ENABLE ove DISABLE

> CONFIG LSM_ENABLE
> 	string "Default set of enabled LSMs"
> 	default ""
> 
> as opposed to
> 
> CONFIG LSM_DISABLE
> 	string "Default set of disabled LSMs"
> 	default ""
> 
> where an empty string is interpreted as "use 'em all" 
> in either case.
> 
>>> When we have full stacking, how could I compile in selinux
>>> but exclude it?
>> Yup, same problem. Same suggested solution?
>>
>> Should lsm.enable/disable= also become a comma-separated list, or
>> should I leave it as a multi-instance thing like I have it?
> 
> I prefer the multi-instance
> 	lsm.disable=selinux lsm.disable=yama
> to the list
> 	lsm.disable=selinux,yama
> 
> but at this point I don't really care all that much.
> 

the comma separated list however is consistent with what is being
done for default order
