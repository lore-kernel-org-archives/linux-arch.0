Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:35208 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbeJCED2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Oct 2018 00:03:28 -0400
Date: Wed, 3 Oct 2018 07:17:57 +1000 (AEST)
From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH security-next v4 09/32] LSM: Provide init debugging
 infrastructure
In-Reply-To: <20181002005505.6112-10-keescook@chromium.org>
Message-ID: <alpine.LRH.2.21.1810030717460.23596@namei.org>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-10-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181002211757.GchuOa_hSxvPw8TLTzMbKckkd5OactiAQQx7TEflJTA@z>

On Mon, 1 Oct 2018, Kees Cook wrote:

> Booting with "lsm.debug" will report future details on how LSM ordering
> decisions are being made.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johansen@canonical.com>



Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>
