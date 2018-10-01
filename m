Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:34586 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbeJBCjI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Oct 2018 22:39:08 -0400
Date: Tue, 2 Oct 2018 05:59:32 +1000 (AEST)
From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH security-next v3 05/29] LSM: Convert from initcall to
 struct lsm_info
In-Reply-To: <20180925001832.18322-6-keescook@chromium.org>
Message-ID: <alpine.LRH.2.21.1810020559060.14406@namei.org>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-6-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181001195932.-zJmEpmpMPp-jRaeKT7w0OcI46PrgJho2r_JczBxm38@z>

On Mon, 24 Sep 2018, Kees Cook wrote:

> In preparation for doing more interesting LSM init probing, this converts
> the existing initcall system into an explicit call into a function pointer
> from a section-collected struct lsm_info array.
> 
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>
