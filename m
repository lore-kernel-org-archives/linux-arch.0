Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:33620 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeJKLK6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 11 Oct 2018 07:10:58 -0400
Date: Thu, 11 Oct 2018 14:45:01 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
Message-ID: <alpine.LRH.2.21.1810111443500.25845@namei.org>
References: <20181011001846.30964-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Jordan Glover <Golden_Miller83@protonmail.ch>, LSM <linux-security-module@vger.kernel.org>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181011034501.3T3obRCqCSEzt4kpJ4ku4yNBthNweAc3ibmMITGhBzE@z>

On Wed, 10 Oct 2018, Kees Cook wrote:

> v5:
> - redesigned to use CONFIG_LSM= and lsm= for both ordering and enabling
> - dropped various Reviewed-bys due to rather large refactoring

Patches 1-10 applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
and next-testing.


-- 
James Morris
<jmorris@namei.org>
