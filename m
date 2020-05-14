From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v17 05/10] fs,landlock: Support filesystem access-control
Date: Thu, 14 May 2020 12:39:58 +0200
Message-ID: <c159d845-6108-4b67-6527-405589fa5382@digikod.net>
References: <20200511192156.1618284-1-mic@digikod.net>
 <20200511192156.1618284-6-mic@digikod.net>
 <alpine.LRH.2.21.2005141335280.30052@namei.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.21.2005141335280.30052@namei.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@amacapital.net>, Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Michael Kerrisk <mtk.manpages@gmail.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>, "Serge E . Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org, x86@kernel.org
List-Id: linux-arch.vger.kernel.org


On 14/05/2020 05:37, James Morris wrote:
> On Mon, 11 May 2020, Mickaël Salaün wrote:
> 
> 
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 45cc10cdf6dd..2276642f8e05 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1517,6 +1517,11 @@ struct super_block {
>>  	/* Pending fsnotify inode refs */
>>  	atomic_long_t s_fsnotify_inode_refs;
>>  
>> +#ifdef CONFIG_SECURITY_LANDLOCK
>> +	/* References to Landlock underlying objects */
>> +	atomic_long_t s_landlock_inode_refs;
>> +#endif
>> +
> 
> This needs to be converted to the LSM API via superblock blob stacking.
> 
> See Casey's old patch: 
> https://lore.kernel.org/linux-security-module/20190829232935.7099-2-casey@schaufler-ca.com/

s_landlock_inode_refs is quite similar to s_fsnotify_inode_refs, but I
can do it once the superblock security blob patch is upstream. Is it a
blocker for now? What is the current status of lbs_superblock?

Anyway, we also need to have a call to landlock_release_inodes() in
generic_shutdown_super(), which does not fit the LSM framework, and I
think it is not an issue. Landlock handling of inodes is quite similar
to fsnotify.
