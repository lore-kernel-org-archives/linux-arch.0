From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH security-next v4 04/32] LSM: Remove initcall tracing
Date: Wed, 3 Oct 2018 07:14:18 +1000 (AEST)
Message-ID: <alpine.LRH.2.21.1810030714080.23596@namei.org>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-5-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002005505.6112-5-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, 1 Oct 2018, Kees Cook wrote:

> This partially reverts commit 58eacfffc417 ("init, tracing: instrument
> security and console initcall trace events") since security init calls
> are about to no longer resemble regular init calls.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>
