From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH v17 05/10] fs,landlock: Support filesystem
 access-control
Date: Fri, 15 May 2020 03:31:38 +1000 (AEST)
Message-ID: <alpine.LRH.2.21.2005150329580.26489@namei.org>
References: <20200511192156.1618284-1-mic@digikod.net> <20200511192156.1618284-6-mic@digikod.net> <alpine.LRH.2.21.2005141335280.30052@namei.org> <c159d845-6108-4b67-6527-405589fa5382@digikod.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-621977297-1589477498=:26489"
Return-path: <kernel-hardening-return-18799-glkh-kernel-hardening=m.gmane-mx.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <c159d845-6108-4b67-6527-405589fa5382@digikod.net>
To: =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@amacapital.net>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Michael Kerrisk <mtk.manpages@gmail.com>, =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>, "Serge E . Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-621977297-1589477498=:26489
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 14 May 2020, Mickaël Salaün wrote:

> > This needs to be converted to the LSM API via superblock blob stacking.
> > 
> > See Casey's old patch: 
> > https://lore.kernel.org/linux-security-module/20190829232935.7099-2-casey@schaufler-ca.com/
> 
> s_landlock_inode_refs is quite similar to s_fsnotify_inode_refs, but I
> can do it once the superblock security blob patch is upstream. Is it a
> blocker for now? What is the current status of lbs_superblock?

Yes it is a blocker. Landlock should not be adding its own functions in 
core code, it should be using the LSM API (and extending that as needed).

> Anyway, we also need to have a call to landlock_release_inodes() in
> generic_shutdown_super(), which does not fit the LSM framework, and I
> think it is not an issue. Landlock handling of inodes is quite similar
> to fsnotify.

fsnotify is not an LSM.

-- 
James Morris
<jmorris@namei.org>

--1665246916-621977297-1589477498=:26489--
