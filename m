Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:35186 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725198AbeJCEBt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Oct 2018 00:01:49 -0400
Date: Wed, 3 Oct 2018 07:16:21 +1000 (AEST)
From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH security-next v4 07/32] LSM: Convert security_initcall()
 into DEFINE_LSM()
In-Reply-To: <20181002005505.6112-8-keescook@chromium.org>
Message-ID: <alpine.LRH.2.21.1810030716170.23596@namei.org>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-8-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181002211621.lL2Rp6eTkU3mSp6EVPmvYGpkZupjdndOKG6j6L2mIoU@z>

On Mon, 1 Oct 2018, Kees Cook wrote:

> Instead of using argument-based initializers, switch to defining the
> contents of struct lsm_info on a per-LSM basis. This also drops
> the final use of the now inaccurate "initcall" naming.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


Reviewed-by: James Morris <james.morris@microsoft.com>

-- 
James Morris
<jmorris@namei.org>
