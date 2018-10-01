Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:34512 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbeJBCdT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Oct 2018 22:33:19 -0400
Date: Tue, 2 Oct 2018 05:53:38 +1000 (AEST)
From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH security-next v3 01/29] LSM: Correctly announce start of
 LSM initialization
In-Reply-To: <20180925001832.18322-2-keescook@chromium.org>
Message-ID: <alpine.LRH.2.21.1810020553330.14406@namei.org>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181001195338.aneWl3eo2LJFb5lJIe7AA_ldrJ9N9lXeTgRXHFiMGkU@z>

On Mon, 24 Sep 2018, Kees Cook wrote:

> For a while now, the LSM core has said it was "initializED", rather than
> "initializING". This adjust the report to be more accurate (i.e. before
> this was reported before any LSMs had been initialized.)
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>
