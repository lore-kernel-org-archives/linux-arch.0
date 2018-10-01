From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH security-next v3 02/29] vmlinux.lds.h: Avoid copy/paste
 of security_init section
Date: Tue, 2 Oct 2018 05:56:08 +1000 (AEST)
Message-ID: <alpine.LRH.2.21.1810020555570.14406@namei.org>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-3-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925001832.18322-3-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, 24 Sep 2018, Kees Cook wrote:

> Avoid copy/paste by defining SECURITY_INIT in terms of SECURITY_INITCALL.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>
