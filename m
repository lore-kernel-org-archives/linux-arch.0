Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeJBEDD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Oct 2018 00:03:03 -0400
Date: Mon, 1 Oct 2018 17:23:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH security-next v3 04/29] LSM: Remove initcall tracing
Message-ID: <20181001172315.225d18dc@gandalf.local.home>
In-Reply-To: <b169724f-c6c2-f4c0-806b-c8e23819ea6a@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org>
        <20180925001832.18322-5-keescook@chromium.org>
        <b169724f-c6c2-f4c0-806b-c8e23819ea6a@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Johansen <john.johansen@canonical.com>
Cc: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>, linux-security-module@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181001212315._r8U3jss2sKShZNzWZM5q0oxuSAAwXnrTD17HhobR5c@z>

On Mon, 1 Oct 2018 14:07:55 -0700
John Johansen <john.johansen@canonical.com> wrote:

> On 09/24/2018 05:18 PM, Kees Cook wrote:
> > This partially reverts commit 58eacfffc417 ("init, tracing: instrument
> > security and console initcall trace events") since security init calls
> > are about to no longer resemble regular init calls.
> > 
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>
> > Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>  
> 
> 
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> 
> though I do think it would be a good idea to add a new set
> of trace points, but that can come as a separate patch
> 
>

Agreed.

-- Steve
