Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sonic304-18.consmr.mail.bf2.yahoo.com ([74.6.128.41]:37633 "EHLO
        sonic304-18.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbeIUGAs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Sep 2018 02:00:48 -0400
Subject: Re: [PATCH security-next v2 19/26] LSM: Introduce CONFIG_LSM_ORDER
From: Casey Schaufler <casey@schaufler-ca.com>
References: <20180920162338.21060-1-keescook@chromium.org>
 <20180920162338.21060-20-keescook@chromium.org>
 <25825681-a465-684d-d48e-79473bca7606@schaufler-ca.com>
Message-ID: <17226f0a-e320-dab0-8691-aa0a22f07544@schaufler-ca.com>
Date: Thu, 20 Sep 2018 17:14:35 -0700
MIME-Version: 1.0
In-Reply-To: <25825681-a465-684d-d48e-79473bca7606@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180921001435.UHNEqKS72-KeJcxNFrentXkAM8yuMzpo5jDzXunfrBg@z>

On 9/20/2018 5:10 PM, Casey Schaufler wrote:
> On 9/20/2018 9:23 AM, Kees Cook wrote:
>> This provides a way to declare LSM initialization order via Kconfig.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  security/Kconfig    | 11 +++++++++++
>>  security/security.c | 38 +++++++++++++++++++++++++++++++++++---
>>  2 files changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/security/Kconfig b/security/Kconfig
>> index 27d8b2688f75..de8202886c1d 100644
>> --- a/security/Kconfig
>> +++ b/security/Kconfig
>> @@ -276,5 +276,16 @@ config DEFAULT_SECURITY
>>  	default "apparmor" if DEFAULT_SECURITY_APPARMOR
>>  	default "" if DEFAULT_SECURITY_DAC
>>  
>> +config LSM_ORDER
>> +	string "Default initialization order of builtin LSMs"
>> +	default "integrity"
> I would like to see the default spelled out rather than
> provided implicitly.
>
>   +	  default "integrity,yama,loadpin,selinux,smack,apparmor,tomoyo"

I see now that comes later in the patch set. Never mind.
