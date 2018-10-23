From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
Date: Tue, 23 Oct 2018 09:48:20 -0700
Message-ID: <96e92224-aedf-5026-d6dd-b29121b4dc0d@schaufler-ca.com>
References: <20181011001846.30964-1-keescook@chromium.org>
 <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
 <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
 <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
 <f68e5f4b-6360-a9e7-597f-89d1d3ca73c1@canonical.com>
 <32stV62RmME8Dj5jKB8Z03zPe_Et72kMo71D8SpgSOHUo6SaROc8DomMWdk5jDGpyqVd8T63NIIK2NdDw95clpF8Uj47Wca2FBFItXDRh7E=@protonmail.ch>
 <38dde301-d77e-35fd-88d4-5cdc5b570ee8@canonical.com>
 <_CkJnKYmEZ4ZF0JtsSYuahAd9sgnX9OtcstjXaeqb8wn5uxfimc6S4jomly7If9VqnOXqXwaiCbJ9ttS6NiqE7n6cQUlwLvfO53paLmacvU=@protonmail.ch>
 <8251564f-ba7a-1777-a606-dec472b32f35@canonical.com>
 <CAGXu5j+2yVZ5DQHyqvJKnSYYqRCzeMtEabBwYFOWkTcwMUWhEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGXu5j+2yVZ5DQHyqvJKnSYYqRCzeMtEabBwYFOWkTcwMUWhEw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>
Cc: Jordan Glover <Golden_Miller83@protonmail.ch>, James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, LSM <linux-security-module@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 10/12/2018 12:01 PM, Kees Cook wrote:
> On Friday, October 12, 2018 3:19 AM, John Johansen
> <john.johansen@canonical.com> wrote:
>> It isn't perfect but it manages consistency across distros as best as
>> can be achieved atm.
> Yeah, this is why I'm okay with the current series: it provides as
> consistent a view as possible, but leaves room for future improvements
> (like adding "+" or "!" or "all" or whatever).
>
> I'm curious to see what SELinux folks think of v5, though. I *think* I
> addressed all the concerns there, even Paul's "I want my distro
> default to not have extreme stacking" case too.
>
> -Kees

Looks like I should go on vacation more often. :)

I am generally opposed to fancy specification languages.
I support the explicit lsm= list specification because you
don't have to know any context to create a boot line that
will work, and be as close to what you've specified as possible
for the kernel configuration. One need look no further than
the mechanisms for setting POSIX ACLs for an example of
how to ensure a feature isn't used.

Had we the foresight to make security= take a list of
modules when Yama was added we might have avoided some of
this brouhaha, but there was no reason to expect that stacking
was ever going to happen back then.
