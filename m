From: Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH v4 2/4] mutex: add support for wound/wait style locks, v5
Date: Wed, 29 May 2013 19:33:26 +0900
Message-ID: <CAAQKjZMPw7Lnn7VFYVkN_ViJgTzREy_uSTFXKHRnEEzo+_=yRg@mail.gmail.com>
References: <20130528144420.4538.70725.stgit@patser>
	<20130528144839.4538.39821.stgit@patser>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0503471475=="
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20130528144839.4538.39821.stgit@patser>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Cc: linux-arch@vger.kernel.org, peterz@infradead.org, x86@kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI mailing list <dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, robclark@gmail.com, rostedt@goodmis.org, tglx@linutronix.de, mingo@elte.hu, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

--===============0503471475==
Content-Type: multipart/alternative; boundary=001a11c36bdc7b4eaf04ddd8e954

--001a11c36bdc7b4eaf04ddd8e954
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Just minor comments

+Usage
> +-----
> +
> +Three different ways to acquire locks within the same w/w class. Common
> +definitions for methods #1 and #2:
> +
> +static DEFINE_WW_CLASS(ww_class);
> +
> +struct obj {
> +       struct ww_mutex lock;
> +       /* obj data */
> +};
> +
> +struct obj_entry {
> +       struct list_head *list;
> +       struct obj *obj;
> +};
> +
> +Method 1, using a list in execbuf->buffers that's not allowed to be
> reordered.
> +This is useful if a list of required objects is already tracked somewhere.
> +Furthermore the lock helper can use propagate the -EALREADY return code
> back to
> +the caller as a signal that an object is twice on the list. This is
> useful if
> +the list is constructed from userspace input and the ABI requires
> userspace to
> +not have duplicate entries (e.g. for a gpu commandbuffer submission
> ioctl).
> +
> +int lock_objs(struct list_head *list, struct ww_acquire_ctx *ctx)
> +{
> +       struct obj *res_obj = NULL;
> +       struct obj_entry *contended_entry = NULL;
> +       struct obj_entry *entry;
> +
> +       ww_acquire_init(ctx, &ww_class);
> +
> +retry:
> +       list_for_each_entry (list, entry) {
> +               if (entry == res_obj) {
>

if (entry->obj == res_obj) {


> +                       res_obj = NULL;
> +                       continue;
> +               }
> +               ret = ww_mutex_lock(&entry->obj->lock, ctx);
> +               if (ret < 0) {
> +                       contended_obj = entry;
>

contended_entry = entry;


> +                       goto err;
> +               }
> +       }
> +
> +       ww_acquire_done(ctx);
> +       return 0;
> +
> +err:
> +       list_for_each_entry_continue_reverse (list, contended_entry, entry)
>

list_for_each_entry_continue_reverse(entry, list, list)?


> +               ww_mutex_unlock(&entry->obj->lock);
> +
> +       if (res_obj)
> +               ww_mutex_unlock(&res_obj->lock);
> +
> +       if (ret == -EDEADLK) {
> +               /* we lost out in a seqno race, lock and retry.. */
> +               ww_mutex_lock_slow(&contended_entry->obj->lock, ctx);
> +               res_obj = contended_entry->obj;
> +               goto retry;
> +       }
> +       ww_acquire_fini(ctx);
> +
> +       return ret;
> +}
> +
> +Method 2, using a list in execbuf->buffers that can be reordered. Same
> semantics
> +of duplicate entry detection using -EALREADY as method 1 above. But the
> +list-reordering allows for a bit more idiomatic code.
> +
> +int lock_objs(struct list_head *list, struct ww_acquire_ctx *ctx)
> +{
> +       struct obj_entry *entry, *entry2;
> +
> +       ww_acquire_init(ctx, &ww_class);
> +
> +       list_for_each_entry (list, entry) {
> +               ret = ww_mutex_lock(&entry->obj->lock, ctx);
> +               if (ret < 0) {
> +                       entry2 = entry;
> +
> +                       list_for_each_entry_continue_reverse (list, entry2)
>

list_for_each_entry_continue_reverse(entry, list, list)?


> +                               ww_mutex_unlock(&entry->obj->lock);
> +
> +                       if (ret != -EDEADLK) {
> +                               ww_acquire_fini(ctx);
> +                               return ret;
> +                       }
> +
> +                       /* we lost out in a seqno race, lock and retry.. */
> +                       ww_mutex_lock_slow(&entry->obj->lock, ctx);
>

shouldn't the wounded task acquire slowpath lock to the above dead locked
entry like this, ww_mutex_lock_slow(&entry2->obj->lock, ctx)?


> +
> +                       /*
> +                        * Move buf to head of the list, this will point
> +                        * buf->next to the first unlocked entry,
> +                        * restarting the for loop.
> +                        */
> +                       list_del(&entry->list);
> +                       list_add(&entry->list, list);
> +               }
> +       }
> +
> +       ww_acquire_done(ctx);
> +       return 0;
> +}
> +
> +Unlocking works the same way for both methods #1 and #2:
> +
> +void unlock_objs(struct list_head *list, struct ww_acquire_ctx *ctx)
> +{
> +       struct obj_entry *entry;
> +
> +       list_for_each_entry (list, entry)
> +               ww_mutex_unlock(&entry->obj->lock);
> +
> +       ww_acquire_fini(ctx);
> +}
> +
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>

--001a11c36bdc7b4eaf04ddd8e954
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra">Hi,<br></div><div class=3D"=
gmail_extra"><br></div><div class=3D"gmail_extra">Just minor comments<br></=
div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">

+Usage<br>
+-----<br>
+<br>
+Three different ways to acquire locks within the same w/w class. Common<br=
>
+definitions for methods #1 and #2:<br>
+<br>
+static DEFINE_WW_CLASS(ww_class);<br>
+<br>
+struct obj {<br>
+ =A0 =A0 =A0 struct ww_mutex lock;<br>
+ =A0 =A0 =A0 /* obj data */<br>
+};<br>
+<br>
+struct obj_entry {<br>
+ =A0 =A0 =A0 struct list_head *list;<br>
+ =A0 =A0 =A0 struct obj *obj;<br>
+};<br>
+<br>
+Method 1, using a list in execbuf-&gt;buffers that&#39;s not allowed to be=
 reordered.<br>
+This is useful if a list of required objects is already tracked somewhere.=
<br>
+Furthermore the lock helper can use propagate the -EALREADY return code ba=
ck to<br>
+the caller as a signal that an object is twice on the list. This is useful=
 if<br>
+the list is constructed from userspace input and the ABI requires userspac=
e to<br>
+not have duplicate entries (e.g. for a gpu commandbuffer submission ioctl)=
.<br>
+<br>
+int lock_objs(struct list_head *list, struct ww_acquire_ctx *ctx)<br>
+{<br>
+ =A0 =A0 =A0 struct obj *res_obj =3D NULL;<br>
+ =A0 =A0 =A0 struct obj_entry *contended_entry =3D NULL;<br>
+ =A0 =A0 =A0 struct obj_entry *entry;<br>
+<br>
+ =A0 =A0 =A0 ww_acquire_init(ctx, &amp;ww_class);<br>
+<br>
+retry:<br>
+ =A0 =A0 =A0 list_for_each_entry (list, entry) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (entry =3D=3D res_obj) {<br></blockquote><=
div><br></div><div>if (entry-&gt;obj =3D=3D res_obj) {<br></div><div>=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">

+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res_obj =3D NULL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ww_mutex_lock(&amp;entry-&gt;obj-&gt;=
lock, ctx);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret &lt; 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 contended_obj =3D entry;<br><=
/blockquote><div><br></div><div>contended_entry =3D entry;<br></div><div>=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">

+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 ww_acquire_done(ctx);<br>
+ =A0 =A0 =A0 return 0;<br>
+<br>
+err:<br>
+ =A0 =A0 =A0 list_for_each_entry_continue_reverse (list, contended_entry, =
entry)<br></blockquote><div><br></div><div>list_for_each_entry_continue_rev=
erse(entry, list, list)?<br></div><div>=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">

+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ww_mutex_unlock(&amp;entry-&gt;obj-&gt;lock);=
<br>
+<br>
+ =A0 =A0 =A0 if (res_obj)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ww_mutex_unlock(&amp;res_obj-&gt;lock);<br>
+<br>
+ =A0 =A0 =A0 if (ret =3D=3D -EDEADLK) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* we lost out in a seqno race, lock and retr=
y.. */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ww_mutex_lock_slow(&amp;contended_entry-&gt;o=
bj-&gt;lock, ctx);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 res_obj =3D contended_entry-&gt;obj;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto retry;<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 ww_acquire_fini(ctx);<br>
+<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+Method 2, using a list in execbuf-&gt;buffers that can be reordered. Same =
semantics<br>
+of duplicate entry detection using -EALREADY as method 1 above. But the<br=
>
+list-reordering allows for a bit more idiomatic code.<br>
+<br>
+int lock_objs(struct list_head *list, struct ww_acquire_ctx *ctx)<br>
+{<br>
+ =A0 =A0 =A0 struct obj_entry *entry, *entry2;<br>
+<br>
+ =A0 =A0 =A0 ww_acquire_init(ctx, &amp;ww_class);<br>
+<br>
+ =A0 =A0 =A0 list_for_each_entry (list, entry) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ww_mutex_lock(&amp;entry-&gt;obj-&gt;=
lock, ctx);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret &lt; 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 entry2 =3D entry;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry_continue_=
reverse (list, entry2)<br></blockquote><div><br></div><div>list_for_each_en=
try_continue_reverse(entry, list, list)?<br></div><div>=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">

+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ww_mutex_unlo=
ck(&amp;entry-&gt;obj-&gt;lock);<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D -EDEADLK) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ww_acquire_fi=
ni(ctx);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* we lost out in a seqno rac=
e, lock and retry.. */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ww_mutex_lock_slow(&amp;entry=
-&gt;obj-&gt;lock, ctx);<br></blockquote><div><br></div><div>shouldn&#39;t =
the wounded task acquire slowpath lock to the above dead locked entry like =
this, ww_mutex_lock_slow(&amp;entry2-&gt;obj-&gt;lock, ctx)?<br>
</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Move buf to head of the =
list, this will point<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* buf-&gt;next to the firs=
t unlocked entry,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* restarting the for loop.=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&amp;entry-&gt;list)=
;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add(&amp;entry-&gt;list,=
 list);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 ww_acquire_done(ctx);<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+Unlocking works the same way for both methods #1 and #2:<br>
+<br>
+void unlock_objs(struct list_head *list, struct ww_acquire_ctx *ctx)<br>
+{<br>
+ =A0 =A0 =A0 struct obj_entry *entry;<br>
+<br>
+ =A0 =A0 =A0 list_for_each_entry (list, entry)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ww_mutex_unlock(&amp;entry-&gt;obj-&gt;lock);=
<br>
+<br>
+ =A0 =A0 =A0 ww_acquire_fini(ctx);<br>
+}<br>
+<br>
<br>
_______________________________________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel@lists.freedesktop.org">dri-devel@lists.freedesk=
top.org</a><br>
<a href=3D"http://lists.freedesktop.org/mailman/listinfo/dri-devel" target=
=3D"_blank">http://lists.freedesktop.org/mailman/listinfo/dri-devel</a><br>
</blockquote></div><br></div></div>

--001a11c36bdc7b4eaf04ddd8e954--

--===============0503471475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0503471475==--
