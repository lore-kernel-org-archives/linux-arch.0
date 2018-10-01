From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH security-next v3 04/29] LSM: Remove initcall tracing
Date: Mon, 1 Oct 2018 15:38:55 -0700
Message-ID: <CAGXu5jJbO7c0Hiw8_9hhkbo74c-56g5ppW8g1ynyPt-WsLaxRw@mail.gmail.com>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-5-keescook@chromium.org>
 <b169724f-c6c2-f4c0-806b-c8e23819ea6a@canonical.com> <20181001172315.225d18dc@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001172315.225d18dc@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>, linux-security-module <linux-security-module@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 1, 2018 at 2:23 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 1 Oct 2018 14:07:55 -0700
> John Johansen <john.johansen@canonical.com> wrote:
>
>> On 09/24/2018 05:18 PM, Kees Cook wrote:
>> > This partially reverts commit 58eacfffc417 ("init, tracing: instrument
>> > security and console initcall trace events") since security init calls
>> > are about to no longer resemble regular init calls.
>> >
>> > Cc: James Morris <jmorris@namei.org>
>> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
>> > Cc: Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>
>> > Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> > Cc: linux-security-module@vger.kernel.org
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>>
>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>>
>> though I do think it would be a good idea to add a new set
>> of trace points, but that can come as a separate patch
>>
>>
>
> Agreed.

BTW, how would this look? I'm not familiar with adding new tracepoints...

-Kees

-- 
Kees Cook
Pixel Security
