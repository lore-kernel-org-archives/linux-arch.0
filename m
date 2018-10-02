Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:35160 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725198AbeJCEA7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Oct 2018 00:00:59 -0400
Date: Wed, 3 Oct 2018 07:15:30 +1000 (AEST)
From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH security-next v4 06/32] vmlinux.lds.h: Move LSM_TABLE
 into INIT_DATA
In-Reply-To: <20181002005505.6112-7-keescook@chromium.org>
Message-ID: <alpine.LRH.2.21.1810030715130.23596@namei.org>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-7-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181002211530.9SxM161QjpLkDYFLfU9bhStK2n4MJX5tUILkA6EQVys@z>

On Mon, 1 Oct 2018, Kees Cook wrote:

> Since the struct lsm_info table is not an initcall, we can just move it
> into INIT_DATA like all the other tables.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johansen@canonical.com>


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>
