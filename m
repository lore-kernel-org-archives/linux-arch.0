From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH security-next v2 26/26] LSM: Add all exclusive LSMs to
 ordered initialization
Date: Fri, 21 Sep 2018 07:57:30 -0700
Message-ID: <78fc6ba1-881a-9c82-ebc1-64311279050c@schaufler-ca.com>
References: <20180920162338.21060-1-keescook@chromium.org>
 <20180920162338.21060-27-keescook@chromium.org>
 <a0165ce9-d15b-eaef-a5e8-2aeb6bdc69f6@schaufler-ca.com>
 <CAGXu5j++wXMUXuqT7m5MZdeXqO=i7RgyKZoLwELfSTx6UPOVSA@mail.gmail.com>
 <7d2cc28b-aee5-ee91-9362-f92f8ca30adc@schaufler-ca.com>
 <6c899d9e-45aa-8159-c402-b3c4d1936112@canonical.com>
 <CAGXu5jKzqij5dY2FYm5rafPNPpF1Tx9BPmK+=FvG+=tpFxpscw@mail.gmail.com>
 <74ecd4ec-491b-93d7-4e3f-46f92121130b@canonical.com>
 <CAGXu5j+QhU2HOicYKqfNo17n9k6DKgt1upa3O2p1b5Gvn6icbQ@mail.gmail.com>
 <915ba7e5-0e10-87ef-f0a9-1d8db2e6de90@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <915ba7e5-0e10-87ef-f0a9-1d8db2e6de90@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: John Johansen <john.johansen@canonical.com>, Kees Cook <keescook@chromium.org>
Cc: James Morris <jmorris@namei.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 9/21/2018 6:19 AM, John Johansen wrote:
> On 09/20/2018 08:02 PM, Kees Cook wrote:
>> On Thu, Sep 20, 2018 at 7:14 PM, John Johansen
>> <john.johansen@canonical.com> wrote:
>>> On 09/20/2018 07:05 PM, Kees Cook wrote:
>>>> On Thu, Sep 20, 2018 at 6:39 PM, John Johansen
>>>> <john.johansen@canonical.com> wrote:
>>>>
>>>> Yes, I like CONFIG_LSM_ENABLE if "empty" means "enable all". Should
>>>> CONFIG_LSM_ENABLE replace all the other CONFIG-based LSM
>>>> enabling/disabling?
>>> I don't particularly like "empty" being "enable all". With that
>>> how would I disable all builtin lsms so that I just boot with
>>> capability.
>>>
>>> An option of all or even * is more explicit and leaves the empty
>>> set to mean disable everything
>> Okay, that works. I prefer "all" FWIW.
>>
> me too, I was just trying to throw out options.

I'll buy that. "all" is fine by me, although it means we
can't have an LSM named "all". :) We should also allow "none"
to mean no LSMs. I know lots of people who love using security=none.
