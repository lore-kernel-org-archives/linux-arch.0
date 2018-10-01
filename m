From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH security-next v3 04/29] LSM: Remove initcall tracing
Date: Mon, 1 Oct 2018 17:23:15 -0400
Message-ID: <20181001172315.225d18dc@gandalf.local.home>
References: <20180925001832.18322-1-keescook@chromium.org>
        <20180925001832.18322-5-keescook@chromium.org>
        <b169724f-c6c2-f4c0-806b-c8e23819ea6a@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b169724f-c6c2-f4c0-806b-c8e23819ea6a@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Johansen <john.johansen@canonical.com>
Cc: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>, linux-security-module@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
