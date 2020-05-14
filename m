Return-Path: <SRS0=nKtn=64=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:35416
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727836AbgENP6H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 May 2020 11:58:07 -0400
Subject: Re: [PATCH v17 05/10] fs,landlock: Support filesystem access-control
References: <20200511192156.1618284-1-mic@digikod.net>
 <20200511192156.1618284-6-mic@digikod.net>
 <alpine.LRH.2.21.2005141335280.30052@namei.org>
 <c159d845-6108-4b67-6527-405589fa5382@digikod.net>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <bcfa8f74-5bc9-b363-5372-b254ba2e88a7@schaufler-ca.com>
Date: Thu, 14 May 2020 08:58:03 -0700
MIME-Version: 1.0
In-Reply-To: <c159d845-6108-4b67-6527-405589fa5382@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>, James Morris <jmorris@namei.org>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@amacapital.net>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Michael Kerrisk <mtk.manpages@gmail.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>, "Serge E . Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org, x86@kernel.org, Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <20200514155803.rGPJhdhFWrBajqKHn7V00jd-lLDM-_QC-08DF_BDsxU@z>

On 5/14/2020 3:39 AM, Micka=C3=ABl Sala=C3=BCn wrote:
> On 14/05/2020 05:37, James Morris wrote:
>> On Mon, 11 May 2020, Micka=C3=ABl Sala=C3=BCn wrote:
>>
>>
>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>> index 45cc10cdf6dd..2276642f8e05 100644
>>> --- a/include/linux/fs.h
>>> +++ b/include/linux/fs.h
>>> @@ -1517,6 +1517,11 @@ struct super_block {
>>>  	/* Pending fsnotify inode refs */
>>>  	atomic_long_t s_fsnotify_inode_refs;
>>> =20
>>> +#ifdef CONFIG_SECURITY_LANDLOCK
>>> +	/* References to Landlock underlying objects */
>>> +	atomic_long_t s_landlock_inode_refs;
>>> +#endif
>>> +
>> This needs to be converted to the LSM API via superblock blob stacking=
=2E
>>
>> See Casey's old patch:=20
>> https://lore.kernel.org/linux-security-module/20190829232935.7099-2-ca=
sey@schaufler-ca.com/
> s_landlock_inode_refs is quite similar to s_fsnotify_inode_refs, but I
> can do it once the superblock security blob patch is upstream. Is it a
> blocker for now? What is the current status of lbs_superblock?

As no currently stackable modules conflict over the superblock
(SELinux and Smack are the existing users) there has been no need
to move its management into the infrastructure. The active push for
stacking does not (yet) include everything needed for SELinux+Smack.
It includes what is needed for SELinux+AppArmor and Smack+AppArmor.
That does not include the superblock blob.

You can include a patch in the landlock set that provides infrastructure
management of the superblock blob. Feel free to glean it from my proposal=
=2E

>
> Anyway, we also need to have a call to landlock_release_inodes() in
> generic_shutdown_super(), which does not fit the LSM framework, and I
> think it is not an issue. Landlock handling of inodes is quite similar
> to fsnotify.
