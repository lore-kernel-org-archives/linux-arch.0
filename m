Return-Path: <SRS0=6TNM=5M=vger.kernel.org=linux-doc-owner@kernel.org>
Subject: Re: [PATCH v15 09/10] samples/landlock: Add a sandbox manager example
References: <20200326202731.693608-1-mic@digikod.net>
 <20200326202731.693608-10-mic@digikod.net>
 <11634607-2fdb-1868-03d0-94096763766f@infradead.org>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <4285db52-e7ce-6a0f-3791-fd39c892489e@digikod.net>
Date: Fri, 27 Mar 2020 15:59:00 +0100
MIME-Version: 1.0
In-Reply-To: <11634607-2fdb-1868-03d0-94096763766f@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-doc-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@amacapital.net>, Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Michael Kerrisk <mtk.manpages@gmail.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>, "Serge E . Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org, x86@kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200327145900.WlepNSUXOwJ7SylNHJ9jbjLoVhBLdtzEsyXFms7848M@z>


On 27/03/2020 00:54, Randy Dunlap wrote:
> Hi,
> 
> On 3/26/20 1:27 PM, Mickaël Salaün wrote:
>> diff --git a/samples/Kconfig b/samples/Kconfig
>> index 9d236c346de5..b54408c5bd86 100644
>> --- a/samples/Kconfig
>> +++ b/samples/Kconfig
>> @@ -120,6 +120,13 @@ config SAMPLE_HIDRAW
>>  	bool "hidraw sample"
>>  	depends on HEADERS_INSTALL
>>  
>> +config SAMPLE_LANDLOCK
>> +	bool "Build Landlock sample code"
>> +	select HEADERS_INSTALL
> 
> I think that this should be like all of the other users of HEADERS_INSTALL
> and depend on that instead of select-ing it.

Ok, I though it made sense to select it automatically, but I'll get back
the "depends on".

Thanks.

> 
>> +	help
>> +	  Build a simple Landlock sandbox manager able to launch a process
>> +	  restricted by a user-defined filesystem access-control security policy.
>> +
>>  config SAMPLE_PIDFD
>>  	bool "pidfd sample"
>>  	depends on HEADERS_INSTALL
> 
> thanks.
> 
