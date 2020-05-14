From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH v17 05/10] fs,landlock: Support filesystem
 access-control
Date: Thu, 14 May 2020 13:37:49 +1000 (AEST)
Message-ID: <alpine.LRH.2.21.2005141335280.30052@namei.org>
References: <20200511192156.1618284-1-mic@digikod.net> <20200511192156.1618284-6-mic@digikod.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-1014880157-1589427470=:30052"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20200511192156.1618284-6-mic@digikod.net>
Sender: linux-fsdevel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@amacapital.net>, Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Michael Kerrisk <mtk.manpages@gmail.com>, =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>, "Serge E . Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1014880157-1589427470=:30052
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 11 May 2020, Mickaël Salaün wrote:


> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 45cc10cdf6dd..2276642f8e05 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1517,6 +1517,11 @@ struct super_block {
>  	/* Pending fsnotify inode refs */
>  	atomic_long_t s_fsnotify_inode_refs;
>  
> +#ifdef CONFIG_SECURITY_LANDLOCK
> +	/* References to Landlock underlying objects */
> +	atomic_long_t s_landlock_inode_refs;
> +#endif
> +

This needs to be converted to the LSM API via superblock blob stacking.

See Casey's old patch: 
https://lore.kernel.org/linux-security-module/20190829232935.7099-2-casey@schaufler-ca.com/



-- 
James Morris
<jmorris@namei.org>

--1665246916-1014880157-1589427470=:30052--
