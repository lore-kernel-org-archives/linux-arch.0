From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH security-next v3 04/29] LSM: Remove initcall tracing
Date: Sun, 30 Sep 2018 19:25:26 -0400
Message-ID: <20180930192526.4480231c@vmware.local.home>
References: <20180925001832.18322-1-keescook@chromium.org>
        <20180925001832.18322-5-keescook@chromium.org>
        <20180926123522.4080d9eb@vmware.local.home>
        <CAGXu5jJyL7FuLRj1XxujpGs9=wUQgS4dRfeGB+HUBqy4mkEBhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGXu5jJyL7FuLRj1XxujpGs9=wUQgS4dRfeGB+HUBqy4mkEBhQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>, linux-security-module <linux-security-module@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 26 Sep 2018 11:35:21 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Wed, Sep 26, 2018 at 9:35 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Mon, 24 Sep 2018 17:18:07 -0700
> > Kees Cook <keescook@chromium.org> wrote:
> >  
> >> This partially reverts commit 58eacfffc417 ("init, tracing: instrument
> >> security and console initcall trace events") since security init calls
> >> are about to no longer resemble regular init calls.  
> >
> > I'm not against the change, but how much are they going to "no longer
> > resemble regular init calls"?  
> 
> My take on "regular" init calls is that they're always run, link-time
> ordered, etc. The changes proposed here will make it so not all
> initialization are run depending on runtime configurations, ordering
> will be flexible, etc.
>

Will it still be a good idea to have a tracepoint for those calls?
Perhaps not an  initcall tracepoint but some other kind?

-- Steve
